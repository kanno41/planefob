import SwiftUI

struct FuelPlannerView: View {
    @StateObject private var viewModel = FuelPlannerViewModel()

    @State private var manualHours: Int = 3
    @State private var manualMinutes: Int = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Text("Time Remaining")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    Text(viewModel.remainingPlannedTimeText)
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                        .monospacedDigit()
                }
                .padding(.top, 24)

                VStack(spacing: 8) {
                    Text("Planning fuel remaining: \(viewModel.plannedGallonsRemaining, specifier: "%.1f") gal")
                    Text("Contingency reserve (not planned): \(viewModel.contingencyTimeText)")
                        .foregroundColor(.secondary)
                    Text("Total onboard time incl. reserve: \(viewModel.totalTimeOnBoardText)")
                        .foregroundColor(.secondary)
                }
                .font(.subheadline)

                GroupBox("Set Time Manually") {
                    HStack {
                        Stepper("Hours: \(manualHours)", value: $manualHours, in: 0...3)
                    }
                    HStack {
                        Stepper("Minutes: \(manualMinutes)", value: $manualMinutes, in: 0...59)
                    }
                    Button("Apply Manual Time") {
                        viewModel.setManualTime(hours: manualHours, minutes: manualMinutes)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.top, 4)
                }

                HStack(spacing: 12) {
                    Button(viewModel.isTimerRunning ? "Stop Flight" : "Start Flight") {
                        viewModel.toggleFlightTimer()
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Fill Up / Reset") {
                        manualHours = 3
                        manualMinutes = 0
                        viewModel.fillUpAndReset()
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Fuel On Board")
        }
    }
}

#Preview {
    FuelPlannerView()
}
