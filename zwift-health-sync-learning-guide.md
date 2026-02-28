# Zwift Health Sync - iOS Development Learning Guide

A hands-on tutorial for building your first native iOS app using Swift and SwiftUI

---

## 🎯 Learning Objectives

By the end of this guide, you'll:
- Build a complete iOS app from scratch using SwiftUI
- Integrate with HealthKit (Apple Health)
- Work with external APIs (Zwift)
- Handle authentication and data persistence
- Deploy to TestFlight for testing

---

## 📚 Phase 1: Setup & SwiftUI Basics (Day 1-2)

### Step 1.1: Create Your First Project

**In Xcode:**
1. Open Xcode → "Create New Project"
2. Choose "iOS" → "App"
3. Project settings:
   - Product Name: `ZwiftHealthSync`
   - Team: (your Apple Developer account - can add later)
   - Organization Identifier: `com.yourname.zwifthealthsync`
   - Interface: **SwiftUI** (not Storyboard!)
   - Language: **Swift**
   - Storage: **None** (we'll add later)
   - Uncheck "Include Tests" for now (keep it simple)

**What you'll see:**
- `ZwiftHealthSyncApp.swift` - Your app's entry point
- `ContentView.swift` - Your first view
- `Assets.xcassets` - Images, colors, icons

### Step 1.2: Understanding SwiftUI Basics

**Try this in ContentView.swift:**

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, Zwift!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Let's build something cool")
                .foregroundColor(.gray)
            
            Button("Tap Me") {
                print("Button tapped!")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
```

**What to learn:**
- `VStack` = vertical stack (also: `HStack` for horizontal, `ZStack` for layered)
- Every view has a `body` that returns `some View`
- Modifiers like `.font()`, `.padding()` customize appearance
- `#Preview` shows live preview in Xcode (Command+Option+Enter to toggle)

**Exercise:**
- Change the text
- Add more buttons
- Try different colors with `.foregroundColor(.blue)` or `.foregroundColor(.orange)`
- Experiment with spacing and padding

---

## 🎨 Phase 2: Building the Onboarding Screen (Day 3-4)

### Step 2.1: Create a New View File

**In Xcode:**
1. Right-click on your project folder → "New File"
2. Choose "SwiftUI View"
3. Name it: `OnboardingView.swift`

### Step 2.2: Build the Onboarding UI

```swift
import SwiftUI

struct OnboardingView: View {
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color(hex: "1a1a1d"), Color(hex: "2d2d32")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                // Logo
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            LinearGradient(
                                colors: [Color.orange, Color.cyan],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 100, height: 100)
                    
                    Text("⚡")
                        .font(.system(size: 50))
                }
                
                // Title
                Text("Sync Zwift to\nApple Health")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Subtitle
                Text("Get accurate power, heart rate, and ride data synced seamlessly")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        print("Connect Zwift tapped")
                    }) {
                        Text("Connect Zwift Account")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        print("Learn More tapped")
                    }) {
                        Text("Learn More")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
    }
}

// Helper to use hex colors
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    OnboardingView()
}
```

**What you're learning:**
- Creating custom views
- Using gradients and colors
- Layout with `VStack`, `HStack`, `ZStack`
- Button styling
- Color extensions for hex values

**Exercise:**
- Change the emoji logo to something else
- Adjust colors and spacing
- Add another button or text element

### Step 2.3: Update Your App to Show Onboarding

In `ZwiftHealthSyncApp.swift`:

```swift
import SwiftUI

@main
struct ZwiftHealthSyncApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()  // Changed from ContentView
        }
    }
}
```

Run it! (Command+R or click the Play button)

---

## 🔄 Phase 3: Navigation & State Management (Day 5-6)

### Step 3.1: Understanding @State and Navigation

SwiftUI uses **state** to manage data and trigger UI updates.

Create `DashboardView.swift`:

```swift
import SwiftUI

struct DashboardView: View {
    @State private var lastSyncTime = "2 hours ago"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Status Card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 12, height: 12)
                            
                            Text("Connected")
                                .font(.headline)
                        }
                        
                        Text("Last synced \(lastSyncTime)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Sync action
                            print("Syncing...")
                        }) {
                            Text("Sync Now")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color.orange, Color.orange.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 2)
                    
                    // Recent Rides Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Rides")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        RideCard(
                            title: "Watopia • Volcano Climb",
                            date: "Today, 7:15 AM",
                            power: 245,
                            duration: "42:15",
                            distance: 18.2
                        )
                        
                        RideCard(
                            title: "France • Ventoux",
                            date: "Yesterday, 6:30 AM",
                            power: 228,
                            duration: "1:18:42",
                            distance: 31.5
                        )
                    }
                }
                .padding()
            }
            .background(Color(hex: "f5f5f7"))
            .navigationTitle("Zwift Health Sync")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RideCard: View {
    let title: String
    let date: String
    let power: Int
    let duration: String
    let distance: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text("✓ Synced")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(6)
            }
            
            HStack(spacing: 20) {
                StatView(value: "\(power)w", label: "Avg Power")
                StatView(value: duration, label: "Duration")
                StatView(value: String(format: "%.1f", distance), label: "Miles")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct StatView: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(.title3, design: .monospaced))
                .fontWeight(.bold)
            Text(label)
                .font(.caption2)
                .foregroundColor(.gray)
                .textCase(.uppercase)
        }
    }
}

#Preview {
    DashboardView()
}
```

**What you're learning:**
- `@State` for reactive UI updates
- `NavigationStack` for navigation
- Breaking down UI into reusable components (RideCard, StatView)
- Passing data between views    with properties

### Step 3.2: Add Navigation from Onboarding to Dashboard

Update `OnboardingView.swift`:

```swift
struct OnboardingView: View {
    @State private var showDashboard = false  // Add this
    
    var body: some View {
        ZStack {
            // ... existing code ...
            
            // Update the Connect button:
            Button(action: {
                showDashboard = true  // Changed this
            }) {
                Text("Connect Zwift Account")
                // ... rest of button code
            }
        }
        .fullScreenCover(isPresented: $showDashboard) {
            DashboardView()
        }
    }
}
```

**What you're learning:**
- `.fullScreenCover` for modal presentation
- `@State` with `$` binding (two-way data flow)

---

## 🏥 Phase 4: HealthKit Integration (Day 7-10)

This is where it gets real! HealthKit is Apple's framework for health data.

### Step 4.1: Enable HealthKit Capability

**In Xcode:**
1. Select your project in the navigator
2. Select your target → "Signing & Capabilities"
3. Click "+ Capability"
4. Add "HealthKit"

### Step 4.2: Update Info.plist

**In Xcode:**
1. Find `Info.plist` in your project
2. Right-click → "Open As" → "Source Code"
3. Add before the final `</dict>`:

```xml
<key>NSHealthShareUsageDescription</key>
<string>We need access to read your workout data to verify sync status.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>We need access to write workout data from Zwift to Apple Health.</string>
```

### Step 4.3: Create a HealthKit Manager

Create new file: `HealthKitManager.swift`

```swift
import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    
    // Types we want to read/write
    let typesToRead: Set<HKSampleType> = [
        HKObjectType.workoutType(),
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .distanceCycling)!
    ]
    
    let typesToWrite: Set<HKSampleType> = [
        HKObjectType.workoutType(),
        HKObjectType.quantityType(forIdentifier: .heartRate)!,
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
        HKObjectType.quantityType(forIdentifier: .cyclingPower)!,
        HKObjectType.quantityType(forIdentifier: .cyclingCadence)!
    ]
    
    @Published var isAuthorized = false
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("Health data not available")
            return
        }
        
        healthStore.requestAuthorization(toShare: typesToWrite, read: typesToRead) { success, error in
            DispatchQueue.main.async {
                self.isAuthorized = success
                if let error = error {
                    print("HealthKit authorization error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Simple function to write a cycling workout
    func saveCyclingWorkout(
        start: Date,
        end: Date,
        distance: Double, // in miles
        avgPower: Double, // in watts
        avgHeartRate: Double, // in bpm
        avgCadence: Double // in rpm
    ) {
        let workout = HKWorkout(
            activityType: .cycling,
            start: start,
            end: end,
            duration: end.timeIntervalSince(start),
            totalEnergyBurned: nil,
            totalDistance: HKQuantity(unit: .mile(), doubleValue: distance),
            metadata: [
                "source": "Zwift",
                HKMetadataKeyIndoorWorkout: true
            ]
        )
        
        healthStore.save(workout) { success, error in
            if success {
                print("Workout saved!")
                // Next: save associated samples (power, HR, cadence)
            } else if let error = error {
                print("Error saving workout: \(error.localizedDescription)")
            }
        }
    }
}
```

**What you're learning:**
- `HKHealthStore` - the main HealthKit interface
- Permission system (read vs write)
- `@Published` for observable changes
- Workout types and quantities

### Step 4.4: Use HealthKit Manager in Your App

Update `OnboardingView.swift`:

```swift
struct OnboardingView: View {
    @StateObject private var healthKit = HealthKitManager()  // Add this
    @State private var showDashboard = false
    
    var body: some View {
        // ... existing UI code ...
        
        Button(action: {
            healthKit.requestAuthorization()  // Request permission first
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showDashboard = true
            }
        }) {
            Text("Connect Zwift Account")
            // ... rest of button
        }
    }
}
```

**Test it:**
- Run the app
- Click "Connect Zwift Account"
- You should see a HealthKit permission dialog!

**What you're learning:**
- `@StateObject` for creating observed objects
- Async operations with `DispatchQueue`

---

## 🌐 Phase 5: Zwift API Integration (Day 11-15)

### Step 5.1: Understanding Zwift's Authentication

Zwift doesn't have an official public API, but there's a well-documented unofficial API. Here's what you need to know:

**Authentication Flow:**
1. User enters Zwift username/password
2. App sends credentials to Zwift's auth endpoint
3. Receives back an access token
4. Use token to fetch workout data

### Step 5.2: Create Network Layer

Create `ZwiftAPI.swift`:

```swift
import Foundation

class ZwiftAPI: ObservableObject {
    @Published var isAuthenticated = false
    private var accessToken: String?
    
    struct AuthResponse: Codable {
        let token: String
        let expiresIn: Int
        
        enum CodingKeys: String, CodingKey {
            case token = "access_token"
            case expiresIn = "expires_in"
        }
    }
    
    struct Activity: Codable {
        let id: Int
        let name: String
        let startDate: String
        let distanceInMeters: Double
        let movingTimeInMs: Int
        let avgWatts: Double?
        let avgHeartRate: Double?
        let avgCadenceInRPM: Double?
        let totalElevationGain: Double?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case startDate = "start_date"
            case distanceInMeters = "distance_in_meters"
            case movingTimeInMs = "moving_time_in_ms"
            case avgWatts = "avg_watts"
            case avgHeartRate = "avg_heart_rate"
            case avgCadenceInRPM = "avg_cadence_in_rpm"
            case totalElevationGain = "total_elevation_gain"
        }
    }
    
    func login(username: String, password: String) async throws {
        let baseURL = "https://secure.zwift.com/auth/rb_bf03269b-b1b8-4ddd-b39f-d7efa52e6b72"
        
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "username": username,
            "password": password,
            "client_id": "Zwift_Mobile_Link"
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
        self.accessToken = authResponse.token
        
        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }
    
    func fetchRecentActivities(limit: Int = 10) async throws -> [Activity] {
        guard let token = accessToken else {
            throw URLError(.userAuthenticationRequired)
        }
        
        // Note: This is a simplified example - actual endpoint may vary
        let urlString = "https://us-or-rly101.zwift.com/api/profiles/me/activities?limit=\(limit)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let activities = try JSONDecoder().decode([Activity].self, from: data)
        
        return activities
    }
}
```

**What you're learning:**
- Swift's modern `async/await` for networking
- `Codable` for JSON parsing
- Bearer token authentication
- Error handling with `throws`

**Important Note:** The Zwift API endpoints above are examples. You'll need to research the current unofficial Zwift API docs or use a library like `zwift-mobile-api` to get the exact endpoints.

### Step 5.3: Create Login Screen

Create `LoginView.swift`:

```swift
import SwiftUI

struct LoginView: View {
    @StateObject private var zwiftAPI = ZwiftAPI()
    @State private var username = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var navigateToDashboard = false
    
    var body: some View {
        ZStack {
            Color(hex: "1a1a1d")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("⚡")
                    .font(.system(size: 60))
                
                Text("Sign in to Zwift")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 16) {
                    TextField("Username or Email", text: $username)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .textContentType(.username)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .textContentType(.password)
                    
                    Button(action: {
                        Task {
                            await handleLogin()
                        }
                    }) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .disabled(isLoading || username.isEmpty || password.isEmpty)
                }
                .padding(.horizontal, 32)
            }
        }
        .alert("Login Failed", isPresented: $showError) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        .fullScreenCover(isPresented: $navigateToDashboard) {
            DashboardView()
                .environmentObject(zwiftAPI)
        }
    }
    
    func handleLogin() async {
        isLoading = true
        
        do {
            try await zwiftAPI.login(username: username, password: password)
            navigateToDashboard = true
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        
        isLoading = false
    }
}

#Preview {
    LoginView()
}
```

**What you're learning:**
- TextField and SecureField for user input
- `Task { }` for calling async functions
- Alert dialogs
- Loading states
- `.environmentObject()` for sharing data between views

---

## 🔗 Phase 6: Putting It All Together (Day 16-20)

### Step 6.1: Create the Sync Logic

Create `SyncManager.swift`:

```swift
import Foundation
import HealthKit

class SyncManager: ObservableObject {
    let healthKit = HealthKitManager()
    let zwiftAPI: ZwiftAPI
    
    @Published var isSyncing = false
    @Published var lastSyncDate: Date?
    @Published var syncedActivities: [String] = [] // Activity IDs
    
    init(zwiftAPI: ZwiftAPI) {
        self.zwiftAPI = zwiftAPI
        loadSyncedActivities()
    }
    
    func syncLatestActivities() async {
        DispatchQueue.main.async {
            self.isSyncing = true
        }
        
        do {
            // 1. Fetch activities from Zwift
            let activities = try await zwiftAPI.fetchRecentActivities(limit: 20)
            
            // 2. Filter out already synced
            let newActivities = activities.filter { activity in
                !syncedActivities.contains(String(activity.id))
            }
            
            // 3. Sync each to HealthKit
            for activity in newActivities {
                try await syncActivityToHealthKit(activity)
                markAsSynced(activityId: String(activity.id))
            }
            
            DispatchQueue.main.async {
                self.lastSyncDate = Date()
                self.isSyncing = false
            }
            
        } catch {
            print("Sync error: \(error)")
            DispatchQueue.main.async {
                self.isSyncing = false
            }
        }
    }
    
    private func syncActivityToHealthKit(_ activity: ZwiftAPI.Activity) async throws {
        // Convert Zwift data to HealthKit format
        let dateFormatter = ISO8601DateFormatter()
        guard let startDate = dateFormatter.date(from: activity.startDate) else {
            return
        }
        
        let duration = TimeInterval(activity.movingTimeInMs) / 1000.0
        let endDate = startDate.addingTimeInterval(duration)
        let distanceInMiles = activity.distanceInMeters / 1609.34
        
        // Save the workout
        healthKit.saveCyclingWorkout(
            start: startDate,
            end: endDate,
            distance: distanceInMiles,
            avgPower: activity.avgWatts ?? 0,
            avgHeartRate: activity.avgHeartRate ?? 0,
            avgCadence: activity.avgCadenceInRPM ?? 0
        )
    }
    
    private func markAsSynced(activityId: String) {
        syncedActivities.append(activityId)
        UserDefaults.standard.set(syncedActivities, forKey: "syncedActivities")
    }
    
    private func loadSyncedActivities() {
        syncedActivities = UserDefaults.standard.stringArray(forKey: "syncedActivities") ?? []
    }
}
```

**What you're learning:**
- Coordinating between multiple managers
- UserDefaults for simple persistence
- Async operations in sequence
- Data transformation between APIs

### Step 6.2: Update Dashboard to Use Real Data

Update `DashboardView.swift`:

```swift
struct DashboardView: View {
    @EnvironmentObject var zwiftAPI: ZwiftAPI
    @StateObject private var syncManager: SyncManager
    @State private var activities: [ZwiftAPI.Activity] = []
    
    init() {
        // Note: This is a workaround - in production you'd use dependency injection
        let api = ZwiftAPI()
        _syncManager = StateObject(wrappedValue: SyncManager(zwiftAPI: api))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Status Card
                    StatusCard(
                        lastSync: syncManager.lastSyncDate,
                        isSyncing: syncManager.isSyncing,
                        onSync: {
                            Task {
                                await syncManager.syncLatestActivities()
                                await loadActivities()
                            }
                        }
                    )
                    
                    // Activities List
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Rides")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ForEach(activities, id: \.id) { activity in
                            RideCardFromActivity(activity: activity)
                        }
                    }
                }
                .padding()
            }
            .background(Color(hex: "f5f5f7"))
            .navigationTitle("Zwift Health Sync")
            .task {
                await loadActivities()
            }
        }
    }
    
    func loadActivities() async {
        do {
            activities = try await zwiftAPI.fetchRecentActivities()
        } catch {
            print("Error loading activities: \(error)")
        }
    }
}

struct StatusCard: View {
    let lastSync: Date?
    let isSyncing: Bool
    let onSync: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 12, height: 12)
                
                Text("Connected")
                    .font(.headline)
            }
            
            if let lastSync = lastSync {
                Text("Last synced \(lastSync.formatted(.relative(presentation: .named)))")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                Text("Never synced")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Button(action: onSync) {
                if isSyncing {
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Syncing...")
                    }
                } else {
                    Text("Sync Now")
                }
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: [Color.orange, Color.orange.opacity(0.8)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .disabled(isSyncing)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
```

**What you're learning:**
- `.task { }` modifier for loading data when view appears
- `ForEach` for dynamic lists
- Date formatting with `.formatted()`
- Passing closures as parameters

---

## 🎨 Phase 7: Polish & Features (Day 21-25)

### Step 7.1: Add Settings Screen

Create `SettingsView.swift`:

```swift
import SwiftUI

struct SettingsView: View {
    @AppStorage("autoSync") private var autoSync = true
    @AppStorage("syncPower") private var syncPower = true
    @AppStorage("syncHeartRate") private var syncHeartRate = true
    @AppStorage("syncCadence") private var syncCadence = true
    @AppStorage("notifications") private var notifications = true
    
    var body: some View {
        NavigationStack {
            List {
                Section("Connections") {
                    HStack {
                        Text("Zwift Account")
                        Spacer()
                        Text("Connected")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Apple Health")
                        Spacer()
                        Text("Authorized")
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Sync Settings") {
                    Toggle("Auto-Sync", isOn: $autoSync)
                    Toggle("Sync Power Data", isOn: $syncPower)
                    Toggle("Sync Heart Rate", isOn: $syncHeartRate)
                    Toggle("Sync Cadence", isOn: $syncCadence)
                }
                
                Section("Notifications") {
                    Toggle("Enable Notifications", isOn: $notifications)
                }
                
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Subscription")
                        Spacer()
                        Text("$2/year")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
```

**What you're learning:**
- `@AppStorage` for UserDefaults with SwiftUI
- `List` and `Section` for settings UI
- `Toggle` controls

### Step 7.2: Add Tab Navigation

Update your main app to use tabs. In `ZwiftHealthSyncApp.swift`:

```swift
@main
struct ZwiftHealthSyncApp: App {
    @StateObject private var zwiftAPI = ZwiftAPI()
    
    var body: some Scene {
        WindowGroup {
            if zwiftAPI.isAuthenticated {
                MainTabView()
                    .environmentObject(zwiftAPI)
            } else {
                OnboardingView()
                    .environmentObject(zwiftAPI)
            }
        }
    }
}
```

Create `MainTabView.swift`:

```swift
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
```

**What you're learning:**
- `TabView` for tab navigation
- `Label` with SF Symbols (Apple's icon set)
- Conditional view rendering

---

## 🚀 Phase 8: Testing & Deployment (Day 26-30)

### Step 8.1: Testing on Device

**You'll need:**
- An actual iPhone (simulator doesn't support HealthKit fully)
- Free Apple Developer account (can use your Apple ID)

**Steps:**
1. Connect your iPhone
2. In Xcode: Select your iPhone as the target device
3. Go to Signing & Capabilities → Team → Add your Apple ID
4. Click Run (Command+R)

**Common issues:**
- "Untrusted Developer" on phone → Settings > General > VPN & Device Management > Trust
- Code signing errors → Make sure your bundle ID is unique

### Step 8.2: Prepare for TestFlight

**In Xcode:**
1. Select "Any iOS Device" as target
2. Product → Archive
3. Wait for archive to complete
4. Window → Organizer → Distribute App
5. TestFlight & App Store → Next → Upload

**You'll need:**
- Paid Apple Developer account ($99/year)
- App Store Connect account set up

### Step 8.3: App Store Requirements

**Required assets:**
- App icon (1024x1024)
- Screenshots (various iPhone sizes)
- Privacy policy URL
- App description
- Keywords
- Support URL

---

## 📝 Next Steps & Best Practices

### Code Quality
- Add error handling everywhere
- Use proper logging (os_log framework)
- Add unit tests for business logic
- Document your code with comments

### Features to Add
- Background sync
- Rich notifications when sync completes
- Ride detail view with charts
- Manual refresh pull-to-refresh
- Search/filter rides
- Export to other platforms

### Performance
- Cache Zwift data locally
- Implement pagination for large ride lists
- Optimize HealthKit queries
- Add loading states everywhere

### Security
- Never store passwords in UserDefaults
- Use Keychain for sensitive data
- Implement token refresh
- Handle expired sessions gracefully

---

## 🎓 Learning Resources

**Apple Official:**
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [HealthKit Documentation](https://developer.apple.com/documentation/healthkit)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

**Community:**
- [Hacking with Swift](https://www.hackingwithswift.com) - Excellent free tutorials
- [SwiftUI Lab](https://swiftui-lab.com) - Advanced techniques
- [r/iOSProgramming](https://reddit.com/r/iOSProgramming) - Community help

**Zwift API:**
- Search GitHub for "zwift api" to find unofficial documentation
- Look for Swift libraries that might already exist

---

## 💡 Tips for Success

1. **Start small** - Get one screen working perfectly before moving on
2. **Use previews** - They're faster than running the simulator
3. **Break it down** - Create small, reusable components
4. **Version control** - Use Git from day one
5. **Test on device early** - Simulators lie, especially for HealthKit
6. **Join communities** - Swift developers are friendly and helpful
7. **Read errors carefully** - Xcode's errors are usually helpful
8. **Celebrate wins** - Getting your first view working is HUGE

---

## 🎯 Project Milestones

**Week 1:** UI working, navigation flow complete  
**Week 2:** HealthKit integration functional  
**Week 3:** Zwift API connected, data flowing  
**Week 4:** Full sync working end-to-end  
**Week 5:** Polish, settings, error handling  
**Week 6:** TestFlight beta, gather feedback  

---

Good luck! You're building something real that solves an actual problem. That's the best kind of learning project.

Feel free to reach out when you hit roadblocks - I'm here to help! 🚴‍♂️⚡
