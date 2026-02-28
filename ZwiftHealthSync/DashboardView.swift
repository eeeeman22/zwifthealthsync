//
//  DashboardView.swift
//  ZwiftHealthSync
//
//  Created by Ian Robinson on 1/31/26.
//

import SwiftUI

struct DashboardView: View {
    @Binding var isPresented: Bool
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
                            lastSyncTime = "a few seconds ago"
                        }) {
                            Text("Sync Now")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [
                                            Color.orange,
                                            Color.orange.opacity(0.8),
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)

                    // Recent Rides Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Rides")
                            .font(Font.title2)
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
                        Button(action:{
                            isPresented = false
                        }) {
                            Text("Back to home")
                                .font(.subheadline)
                        }
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
                    Text(date)
                }

                Spacer()

                Text("✓ Synced")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(6)
            }

            HStack(spacing: 20) {
                StatView(value: "\(power)w", label: "Avg Power")
                StatView(value: duration, label: "Duration")
                StatView(
                    value: String(format: "%.1f", distance),
                    label: "Miles"
                )
            }
        }
        .padding()
        .background(.white)
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
    DashboardView(isPresented: .constant(true))
}
