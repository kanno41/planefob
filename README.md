# Plane Fuel Tracker (iOS SwiftUI)

A simple iOS SwiftUI app for tracking fuel-time remaining in flight.

## Behavior implemented

- Shows **Time Remaining** first and prominently in `hh:mm`.
- Assumes:
  - Full tank = **36 gallons**
  - Planning endurance = **3:00**
  - Contingency reserve = **0:45** (shown separately, not used for planning countdown)
- Lets you:
  - Start/Stop a flight timer that counts down planned time.
  - Manually set planned time remaining.
  - Tap **Fill Up / Reset** to restore planned time to 3:00.

## Project layout

- `PlaneFuelTracker.xcodeproj` – Xcode project file and shared scheme.
- `PlaneFuelTrackerApp.swift` – App entry point.
- `FuelPlannerView.swift` – Main screen UI.
- `FuelPlannerViewModel.swift` – Timer + fuel math.

## Build in Xcode

1. Open `PlaneFuelTracker.xcodeproj` in Xcode.
2. Select the `PlaneFuelTracker` scheme.
3. Build and run on an iOS simulator or device.

### Command-line build (macOS with Xcode installed)

```bash
xcodebuild -project PlaneFuelTracker.xcodeproj -scheme PlaneFuelTracker -destination 'generic/platform=iOS Simulator' build
```
