//
//  ContentView.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import SwiftUI
import CoreBluetooth
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: BluetoothViewModel
    @State private var showBluetoothAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Button(viewModel.isScanning ? "Scanning..." : "Scan for devices") {
                    if viewModel.isBluetoothOn {
                        if viewModel.isScanning {
                            viewModel.stopScanning()
                        } else {
                            viewModel.startScanning()
                        }
                    } else {
                        showBluetoothAlert = true
                    }
                }
                .padding()
                .disabled(viewModel.isScanning)
                
                List {
                    Section(header: Text("Found devices")) {
                        ForEach(viewModel.devices) { device in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(device.name)
                                    Text(device.id.uuidString)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if viewModel.connectedPeripheral?.identifier == device.id {
                                    Text("Connected")
                                        .foregroundColor(.green)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.connect(to: device.peripheral)
                            }
                        }
                    }
                    
                    if let connected = viewModel.connectedPeripheral {
                        Section(header: Text("Device: \(connected.name ?? "Unknown")")) {
                            Button("Disconnect device") {
                                viewModel.disconnect()
                            }
                            .foregroundColor(.red)
                            
                            ForEach(viewModel.services) { service in
                                VStack(alignment: .leading) {
                                    Text(service.name)
                                        .font(.headline)
                                    ForEach(service.characteristics) { characteristic in
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(characteristic.name)
                                                .font(.subheadline)
                                            if let value = characteristic.value {
                                                Text("\(value)")
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("BLE devices")
            .alert("Bluetooth is Off", isPresented: $showBluetoothAlert) {
                Button("Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please turn on Bluetooth to scan for devices.")
            }
        }
    }
}
