//
//  BluetoothViewModel.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import Foundation
import CoreBluetooth
import Combine

final class BluetoothViewModel: NSObject, ObservableObject {
    @Published var devices: [BLEDevice] = []
    @Published var connectedPeripheral: CBPeripheral?
    @Published var isScanning = false
    @Published var isBluetoothOn = false
    @Published var services: [BLEService] = []

    private var centralManager: CBCentralManager!

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }

    func startScanning() {
        if centralManager.state == .poweredOn {
            devices.removeAll()
            services.removeAll()
            isScanning = true
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }

    func stopScanning() {
        if centralManager.state == .poweredOn {
            centralManager.stopScan()
            isScanning = false
        }
    }

    func connect(to peripheral: CBPeripheral) {
        connectedPeripheral = peripheral
        connectedPeripheral?.delegate = self
        stopScanning()
        centralManager.connect(peripheral, options: nil)
    }

    func disconnect() {
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            connectedPeripheral = nil
            services.removeAll()
        }
    }
}

// MARK: - CBCentralManagerDelegate, CBPeripheralDelegate
extension BluetoothViewModel: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        isBluetoothOn = (central.state == .poweredOn)
        if !isBluetoothOn {
            isScanning = false
            devices.removeAll()
            connectedPeripheral = nil
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !devices.contains(where: { $0.id == peripheral.identifier }) {
            let advName = advertisementData[CBAdvertisementDataLocalNameKey] as? String
            let device = BLEDevice(id: peripheral.identifier,
                                   peripheral: peripheral,
                                   name: peripheral.name ?? "Unknown",
                                   advertisedName: advName,
                                   rssi: RSSI.intValue)
            devices.append(device)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        services.removeAll()
        guard let discoveredServices = peripheral.services else { return }

        for service in discoveredServices {
            let bleService = BLEService(id: service.uuid.uuidString,
                                        name: service.uuid.serviceName,
                                        characteristics: [])
            services.append(bleService)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let chars = service.characteristics else { return }

        if let serviceIndex = services.firstIndex(where: { $0.id == service.uuid.uuidString }) {
            let bleChars: [BLECharacteristic] = chars.map {
                BLECharacteristic(id: $0.uuid.uuidString, name: $0.uuid.characteristicName, value: nil)
            }
            services[serviceIndex].characteristics = bleChars

            chars.forEach { peripheral.readValue(for: $0) }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let value = characteristic.value else { return }

        let valueString: String

        if value.count == 1 {
            valueString = "\(value[0])"
        } else if value.count == 2 {
            let num = UInt16(value[0]) | (UInt16(value[1]) << 8)
            valueString = "\(num)"
        } else if let str = String(data: value, encoding: .utf8), !str.isEmpty {
            valueString = str
        } else {
            valueString = value.map { String(format: "%02X", $0) }.joined(separator: " ")
        }

        for sIndex in services.indices {
            if let cIndex = services[sIndex].characteristics.firstIndex(where: { $0.id == characteristic.uuid.uuidString }) {
                services[sIndex].characteristics[cIndex].value = valueString
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        peripheral.discoverServices(nil)
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        connectedPeripheral = nil
        services.removeAll()
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral == connectedPeripheral {
            connectedPeripheral = nil
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
}
