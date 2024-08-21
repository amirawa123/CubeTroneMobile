import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'device.dart';
import 'widgets.dart';

class Device {
  BluetoothDevice device;
  bool isAvailable;
  int? rssi;

  Device(this.device, this.isAvailable, [this.rssi]);
}

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  ConnectionSt createState() => ConnectionSt();
}

class ConnectionSt extends State<Connection> {
  List<Device> devices = [];
  late StreamSubscription<BluetoothDiscoveryResult>? streamSubscription;

  @override
  void initState() {
    super.initState();
    startDiscovery();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  void startDiscovery() {
    streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen(
      (r) {
        setState(() {
          final existingDeviceIndex = devices.indexWhere(
            (device) => device.device == r.device,
          );
          if (existingDeviceIndex != -1) {
            devices[existingDeviceIndex].isAvailable = true;
            devices[existingDeviceIndex].rssi = r.rssi;
          } else {
            devices.add(
              Device(
                r.device,
                true,
                r.rssi,
              ),
            );
          }
        });
      },
    );
  }

  void restartDiscovery() {
    setState(() {
      devices.clear();
    });
    startDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    final availableDevices =
        devices.where((device) => device.isAvailable).toList();

    List<DeviceList> list = availableDevices
        .map(
          (device) => DeviceList(
            device: device.device,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Main(device: device.device);
                  },
                ),
              );
            },
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection',
            style: TextStyle(color: Color(0xFFFFFFFF))),
        backgroundColor: const Color(0xFFFB8F48),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: list,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.08,
                child: ElevatedButton(
                  onPressed: restartDiscovery,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: const Color(0xFFFB8F48),
                  ),
                  child: Text(
                    'Scan Again',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        color: const Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
