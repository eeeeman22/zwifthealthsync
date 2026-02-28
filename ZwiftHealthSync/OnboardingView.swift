//
//  Untitled.swift
//  ZwiftHealthSync
//
//  Created by Ian Robinson on 1/31/26.
//
import SwiftUI

struct OnboardingView: View {
    @State private var showDashboard = false
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
                Text("Sync Zwift to\n Apple Health")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                // Subtitle
                Text(
                    "Get accurate, power, heart rate, and ride data synced seamlessly"
                )
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

                Spacer(minLength: 24)

                VStack(spacing: 12) {
                    Button(action: {
                        print("connect Zwift tapped")
                        showDashboard = true
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
                        print("Learn more tapped")
                    }) {
                        Text("Learn more")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        Color.gray.opacity(0.3),
                                        lineWidth: 1
                                    )
                            )
                    }

                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
            .fullScreenCover(isPresented: $showDashboard){
                DashboardView(isPresented: $showDashboard)
            }
        }
    }
}

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
