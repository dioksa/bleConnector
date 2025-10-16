//
//  BLEService.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

struct BLEService: Identifiable {
    let id: String
    let name: String
    var characteristics: [BLECharacteristic]
}

struct BLECharacteristic: Identifiable {
    let id: String
    let name: String
    var value: String?
}
