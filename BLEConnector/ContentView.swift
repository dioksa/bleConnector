//
//  ContentView.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button("Scan for devices") {
                    // TODO: - Add action
                }
                .padding()
                
                List {
                    Section(header: Text("Found devices")) {
                        // TODO: - Add a list of devices
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationTitle("BLE devices")
        }
    }
}

#Preview {
    ContentView()
}
