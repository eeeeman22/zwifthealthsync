# Zwift Health Sync

A native iOS app that syncs Zwift cycling workout data to Apple Health.

## About This Project

This is a **learning project** for Swift and SwiftUI development. The approach:

- **Claude AI** generated a comprehensive [learning guide](zwift-health-sync-learning-guide.md) and [wireframes](zwift-health-sync-wireframes.html) to provide structure and direction
- **I write every line of code by hand** - no copy/paste from the guide
- **Learning by doing** - asking questions and working through problems along the way

This is a work in progress with plenty left to build.

## Current Progress

### Completed
- [x] Project setup in Xcode
- [x] Basic SwiftUI fundamentals (VStack, HStack, buttons, text)
- [x] Onboarding screen with gradient backgrounds and styling
- [x] Dashboard view with ride cards and stats
- [x] Navigation between views using `fullScreenCover`
- [x] Reusable components (RideCard, StatView)
- [x] Color extension for hex values

### In Progress
- [ ] HealthKit integration (manager started, authorization not complete)

### Not Started
- [ ] Zwift API integration
- [ ] Actual data syncing
- [ ] Settings screen
- [ ] Tab navigation
- [ ] Data persistence
- [ ] Error handling
- [ ] TestFlight deployment

## Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Health Integration:** HealthKit
- **Platform:** iOS

## Project Structure

```
ZwiftHealthSync/
├── ZwiftHealthSyncApp.swift    # App entry point
├── ContentView.swift           # Initial SwiftUI experiments
├── OnboardingView.swift        # Onboarding/welcome screen
├── DashboardView.swift         # Main dashboard with ride list
├── HealthKitManager.swift      # HealthKit integration (WIP)
└── Assets.xcassets/            # App icons and colors
```

## Learning Resources

The [learning guide](zwift-health-sync-learning-guide.md) covers:
- SwiftUI basics and layout
- Navigation and state management
- HealthKit integration
- Networking with async/await
- App polish and deployment

## How to Run

1. Clone the repo
2. Open `ZwiftHealthSync.xcodeproj` in Xcode
3. Select a simulator or device and hit Run

## Requirements

- Xcode 15+
- iOS 17+
- Apple Developer account (for device testing and HealthKit)
