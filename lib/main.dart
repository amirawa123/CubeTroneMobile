import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';
import 'dart:math';
import 'shapes.dart';
import 'connection.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const Opening());
}

class Opening extends StatefulWidget {
  const Opening({super.key});

  @override
  OpeningState createState() => OpeningState();
}

class OpeningState extends State<Opening> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late ValueNotifier<String> binaryNotifier;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
    binaryNotifier = ValueNotifier<String>('');
    numberGenerator();
  }

  @override
  void dispose() {
    controller.dispose();
    binaryNotifier.dispose();
    timer?.cancel();
    super.dispose();
  }

  void numberGenerator() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      final random = Random();
      final binaryNumbers = List.generate(8, (_) => random.nextInt(2));
      binaryNotifier.value = binaryNumbers.join();
    });
  }

  Future<void> delayAndEnableBluetooth() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(seconds: 3));
    while (true) {
      final isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
      if (isEnabled != null && isEnabled) {
        break;
      } else {
        await FlutterBluetoothSerial.instance.requestEnable();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubetrone',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      home: FutureBuilder(
        future: delayAndEnableBluetooth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.width * 0.05,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: RotationTransition(
                      turns: controller,
                      child: Image.asset('images/gear.png'),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.width * 0.55,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ValueListenableBuilder(
                      valueListenable: binaryNotifier,
                      builder: (context, value, _) {
                        return TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Color(0xFFFC650C),
                          ),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          controller: TextEditingController(text: value),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'images/visual id.png',
                    ),
                  ),
                  line(
                    startPoint: const Offset(0, 1),
                    endPoint: const Offset(0.13, 0.87),
                  ),
                  line(
                    startPoint: const Offset(0.12, 0.8725),
                    endPoint: const Offset(0.2, 0.8725),
                  ),
                  line(
                    startPoint: const Offset(0.19, 0.876),
                    endPoint: const Offset(0.33, 0.74),
                  ),
                  circle(
                    centerX: 0.35,
                    centerY: 0.72,
                  ),
                  line(
                    startPoint: const Offset(0.15, 1),
                    endPoint: const Offset(0.23, 0.92),
                  ),
                  line(
                    startPoint: const Offset(0.22, 0.9225),
                    endPoint: const Offset(0.3, 0.9225),
                  ),
                  line(
                    startPoint: const Offset(0.29, 0.926),
                    endPoint: const Offset(0.38, 0.84),
                  ),
                  circle(
                    centerX: 0.4,
                    centerY: 0.82,
                  ),
                  line(
                    startPoint: const Offset(0, 0.85),
                    endPoint: const Offset(0.08, 0.77),
                  ),
                  line(
                    startPoint: const Offset(0.07, 0.7725),
                    endPoint: const Offset(0.15, 0.7725),
                  ),
                  line(
                    startPoint: const Offset(0.14, 0.776),
                    endPoint: const Offset(0.23, 0.69),
                  ),
                  circle(
                    centerX: 0.25,
                    centerY: 0.67,
                  ),
                  line(
                    startPoint: const Offset(0.65, 1),
                    endPoint: const Offset(0.83, 0.87),
                  ),
                  line(
                    startPoint: const Offset(0.837, 0.865),
                    endPoint: const Offset(0.851, 0.855),
                  ),
                  line(
                    startPoint: const Offset(0.858, 0.85),
                    endPoint: const Offset(0.97, 0.77),
                  ),
                  line(
                    startPoint: const Offset(0.977, 0.765),
                    endPoint: const Offset(0.991, 0.755),
                  ),
                  line(
                    startPoint: const Offset(0.84, 1),
                    endPoint: const Offset(1, 0.88),
                    color: Colors.black,
                  ),
                ],
              ),
            );
          } else {
            return const Connection();
          }
        },
      ),
    );
  }
}
