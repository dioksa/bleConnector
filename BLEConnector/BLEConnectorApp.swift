//
//  BLEConnectorApp.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import SwiftUI

@main
struct BLEConnectorApp: App {
    @StateObject private var viewModel = BluetoothViewModel()
    @State private var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            if isLoading {
                SplashScreenView {
                    isLoading = false
                }
            } else {
                ContentView(viewModel: viewModel)
            }
        }
    }
}
