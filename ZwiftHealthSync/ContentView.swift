//
//  ContentView.swift
//  ZwiftHealthSync
//
//  Created by Ian Robinson on 1/31/26.
//

import SwiftUI

var count: Int = 0

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, Zwift!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Let's build something cool")
                .foregroundColor(.gray)
            
            Button("Tap me") {
                count = count + 1
                print("Button tapped #count: \(count)")
            }
            .buttonStyle(.borderedProminent)
            
            Button("I don't do anything") {
            }
            .buttonStyle(.automatic)
            .disabled(true)

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
