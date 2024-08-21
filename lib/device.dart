import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceList extends StatelessWidget {
  final VoidCallback onTap;
  final BluetoothDevice device;

  const DeviceList({super.key, required this.onTap, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: const Icon(Icons.devices, color: Color(0xFF3B82F6)),
        title: Text(device.name ?? "Unknown Device",
            style: const TextStyle(color: Color(0xFF3B82F6))),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            backgroundColor: const Color(0xFFFB8F48),
          ),
          child:
              const Text('Connect', style: TextStyle(color: Color(0xFFFFFFFF))),
        ));
  }
}
