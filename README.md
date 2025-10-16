# BLEConnector

### Project Overview
This project is a **BLEConnector** for iOS, developed using **Swift** and the **Core Bluetooth framework**, with **SwiftUI** for the user interface. The application allows users to discover nearby BLE devices, connect to them, read their services and characteristics, and display the retrieved data in a clear, user-friendly UI.

---

### Features

#### BLE Device Interaction
- Discover nearby BLE devices using Core Bluetooth.
- Connect to a selected BLE peripheral.
- Read services and characteristics of the connected device.
- Support for emulated BLE devices for testing purposes.

#### User Interface (UI)
- Simple and clear interface for scanning and displaying devices.
- Display of connected device information, including services and characteristics.
- Universal display of all characteristic values (numeric or string).
- Reactive UI updates using SwiftUI and `@Published` properties.

#### Platform Compatibility
- Works on **iOS devices** (iPhone, iPad).
- Compatible with the latest iOS versions supporting Core Bluetooth and SwiftUI.

---

### Technical Details

#### Architecture
- MVVM architecture using `ObservableObject` for state management.
- `BluetoothViewModel` handles all BLE interactions and state updates.
- Services and characteristics are represented as models:
  - `BLEService`
  - `BLECharacteristic`
- SwiftUI `Views` are bound to `@Published` properties for automatic UI updates.

#### BLE Handling
- Scanning for BLE devices with `CBCentralManager`.
- Connection management with `CBPeripheralDelegate` and `CBCentralManagerDelegate`.
- Service and characteristic discovery with reading all values.
- Universal parsing of characteristic values into readable strings.
- Automatic rescan on peripheral disconnection.

#### Universal Handling
- All service UUIDs and characteristic UUIDs are handled dynamically.
- Values are displayed without special casing, ensuring numeric and string data appear correctly.

---

### Setup Instructions

1. **Clone Repository**
   ```bash
   git clone https://github.com/dioksa/bleConnector.git
   
2. **Open Project**  
   Open `BLEConnector.xcworkspace` in Xcode.
   
3. **Run on Device**
   BLE requires a real iOS device; the simulator does **not** support Core Bluetooth.

4. **BLE Device Emulation**

- Install nRF Connect Mobile or iOS equivalent.
- Follow tutorial: Emulate BLE device using nRF Connect.
- Use the emulated device to test scanning, connecting, and reading characteristics.

### Notes for Developers

- Bluetooth must be enabled on the device.
- All characteristics are read dynamically and displayed as string or hex format.
- UI updates automatically when new devices, services, or characteristic values are discovered.
- Git commits should follow a clear structure with descriptive messages.

### Contact

- **Name:** Oksana Dionisieva  
- **Email:** atty.ltd@gmail.com 
- **LinkedIn:** https://www.linkedin.com/in/oksana-dionisieva  
- **GitHub:** https://github.com/dioksa

