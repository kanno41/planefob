import Foundation
import Combine

final class FuelPlannerViewModel: ObservableObject {
    // Planning values
    let fullTankGallons: Double = 36
    let plannedFlightMinutes: Int = 180
    let contingencyMinutes: Int = 45

    @Published var remainingPlannedSeconds: Int
    @Published var isTimerRunning = false

    private var timerCancellable: AnyCancellable?

    init() {
        self.remainingPlannedSeconds = plannedFlightMinutes * 60
    }

    var remainingPlannedTimeText: String {
        Self.format(seconds: remainingPlannedSeconds)
    }

    var plannedGallonsRemaining: Double {
        let gallonsPerSecond = fullTankGallons / Double(plannedFlightMinutes * 60)
        return max(0, gallonsPerSecond * Double(remainingPlannedSeconds))
    }

    var contingencyTimeText: String {
        Self.format(seconds: contingencyMinutes * 60)
    }

    var totalTimeOnBoardText: String {
        Self.format(seconds: remainingPlannedSeconds + contingencyMinutes * 60)
    }

    func setManualTime(hours: Int, minutes: Int) {
        stopTimer()
        let clampedHours = min(max(0, hours), 3)
        let clampedMinutes = min(max(0, minutes), 59)
        let totalMinutes = min(plannedFlightMinutes, clampedHours * 60 + clampedMinutes)
        remainingPlannedSeconds = totalMinutes * 60
    }

    func fillUpAndReset() {
        stopTimer()
        remainingPlannedSeconds = plannedFlightMinutes * 60
    }

    func toggleFlightTimer() {
        isTimerRunning ? stopTimer() : startTimer()
    }

    private func startTimer() {
        guard !isTimerRunning else { return }
        isTimerRunning = true

        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.remainingPlannedSeconds > 0 {
                    self.remainingPlannedSeconds -= 1
                } else {
                    self.stopTimer()
                }
            }
    }

    private func stopTimer() {
        isTimerRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    private static func format(seconds: Int) -> String {
        let totalMinutes = max(0, seconds / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
}
