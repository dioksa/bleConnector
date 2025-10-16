//
//  BLEDevice.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import Foundation
import CoreBluetooth

struct BLEDevice: Identifiable {
    let id: UUID
    let peripheral: CBPeripheral
    var name: String
    var advertisedName: String?
    var rssi: Int?
    var characteristics: [CBCharacteristic] = []
}
