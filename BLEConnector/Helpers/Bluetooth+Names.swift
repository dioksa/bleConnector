//
//  Bluetooth+Names.swift
//  BLEConnector
//
//  Created by Oksana Dionisieva on 16.10.2025.
//

import CoreBluetooth

extension CBUUID {
    var serviceName: String {
        switch uuidString.uppercased() {
        case "180A": return "Device Information"
        case "180F": return "Battery Service"
        case "180D": return "Heart Rate"
        case "1809": return "Health Thermometer"
        case "181A": return "Environmental Sensing"
        case "181C": return "User Data"
        case "1805": return "Current Time"
        case "1810": return "Blood Pressure"
        default: return "Service \(uuidString)"
        }
    }
    
    var characteristicName: String {
        switch uuidString.uppercased() {
        case "2A19": return "Battery Level"
        case "2A29": return "Manufacturer Name"
        case "2A24": return "Model Number"
        case "2A25": return "Serial Number"
        case "2A26": return "Firmware Revision"
        case "2A27": return "Hardware Revision"
        case "2A37": return "Heart Rate Measurement"
        default: return "Characteristic \(uuidString)"
        }
    }
}
