import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';
import 'shapes.dart';

class Main extends StatefulWidget {
  final BluetoothDevice? device;

  const Main({super.key, this.device});

  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> with TickerProviderStateMixin {
  late BluetoothConnection? connection;
  bool isConnecting = true;
  int widgets = 0;
  final gridViewKey = GlobalKey();
  List<Widget> generatedChildren = [];
  bool isExpanded1 = false;
  bool isExpanded2 = false;
  bool isExpanded3 = false;
  bool showDC1 = false;
  late AnimationController controller1;
  String messageIR1 = '1';
  bool showDC2 = false;
  late AnimationController controller2;
  String messageIR2 = '1';
  bool showCar = false;
  bool showServo1 = false;
  double servoAngle1 = 90;
  bool showServo2 = false;
  double servoAngle2 = 90;
  bool showServo3 = false;
  double servoAngle3 = 90;
  bool showBuzzer = false;
  bool isPressed = false;
  bool showUltrasonic1 = false;
  String messageUltrasonic1 = '  ';
  bool showUltrasonic2 = false;
  String messageUltrasonic2 = '255';
  bool showDisplay = false;
  String messageDisplay = '';
  bool showGyro = false;
  String messageGyro = '0';
  String partialData = '';

  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.device!.address).then((conn) {
      connection = conn;
      setState(() {
        isConnecting = false;
      });
      readMessage();
    }).catchError((error) {});
    controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    controller2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    if (connection!.isConnected) {
      connection!.dispose();
    }
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  List<Widget> generateChildren() {
    generatedChildren = [];
    if (showDC1) {
      void reverse() {
        controller1.reverse(from: 1.0).then((_) => reverse());
      }

      generatedChildren.add(
        Container(
          key: const ValueKey(1),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight * 0.05;
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.15,
                    left: constraints.maxWidth * 0.25,
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxHeight * 0.5,
                    child: RotationTransition(
                      turns: controller1,
                      child: Image.asset('images/wheel.png'),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.075,
                    left: constraints.maxWidth * 0.7,
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxHeight * 0.25,
                    child: GestureDetector(
                      onTap: () {
                        sendMessage('1:F');
                        controller1
                            .forward(from: 0.0)
                            .then((_) => controller1.repeat());
                      },
                      child: CustomPaint(
                        painter: ClockwiseArrow(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.04,
                    left: constraints.maxWidth * 0.785,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'F',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.075,
                    left: constraints.maxWidth * 0.05,
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxHeight * 0.25,
                    child: GestureDetector(
                      onTap: () {
                        sendMessage('1:R');
                        reverse();
                      },
                      child: CustomPaint(
                        painter: CounterClockwiseArrow(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.04,
                    left: constraints.maxWidth * 0.065,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'R',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  line(
                    startPoint: const Offset(0.2, 0.85),
                    endPoint: const Offset(0.8, 0.85),
                    color: messageIR1 == '1'
                        ? const Color(0xFFE0E0E0)
                        : Colors.black,
                    strokeWidth: 20,
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
    if (showDC2) {
      void reverse() {
        controller2.reverse(from: 1.0).then((_) => reverse());
      }

      generatedChildren.add(
        Container(
          key: const ValueKey(2),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight * 0.05;
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.15,
                    left: constraints.maxWidth * 0.25,
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxHeight * 0.5,
                    child: RotationTransition(
                      turns: controller2,
                      child: Image.asset('images/wheel.png'),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.075,
                    left: constraints.maxWidth * 0.7,
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxHeight * 0.25,
                    child: GestureDetector(
                      onTap: () {
                        sendMessage('2:FW');
                        controller2
                            .forward(from: 0.0)
                            .then((_) => controller2.repeat());
                      },
                      child: CustomPaint(
                        painter: ClockwiseArrow(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.04,
                    left: constraints.maxWidth * 0.785,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'FW',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.075,
                    left: constraints.maxWidth * 0.05,
                    width: constraints.maxWidth * 0.25,
                    height: constraints.maxHeight * 0.25,
                    child: GestureDetector(
                      onTap: () {
                        sendMessage('2:BW');
                        reverse();
                      },
                      child: CustomPaint(
                        painter: CounterClockwiseArrow(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.04,
                    left: constraints.maxWidth * 0.065,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'BW',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  line(
                    startPoint: const Offset(0.2, 0.85),
                    endPoint: const Offset(0.8, 0.85),
                    color: messageIR2 == '1'
                        ? const Color(0xFFE0E0E0)
                        : Colors.black,
                    strokeWidth: 20,
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
    if (showCar) {
      generatedChildren.add(
        Container(
          key: const ValueKey(3),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight * 0.05;
              return Stack(
                children: [
                  circle(
                      centerX: 0.5,
                      centerY: 0.5,
                      radius: 0.075,
                      fill: true,
                      color: const Color(0xFFFB8F48)),
                  Positioned(
                    top: constraints.maxHeight * 0.175,
                    left: constraints.maxWidth * 0.4735,
                    width: constraints.maxWidth * 0.053,
                    height: constraints.maxHeight * 0.2,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:Up'),
                      child: line(
                        startPoint: const Offset(0.5, 0),
                        endPoint: const Offset(0.5, 1),
                        color: const Color(0xFFFB8F48),
                        strokeWidth: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.075,
                    left: constraints.maxWidth * 0.425,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'Up',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.625,
                    left: constraints.maxWidth * 0.4735,
                    width: constraints.maxWidth * 0.053,
                    height: constraints.maxHeight * 0.2,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:Down'),
                      child: line(
                        startPoint: const Offset(0.5, 0),
                        endPoint: const Offset(0.5, 1),
                        color: const Color(0xFFFB8F48),
                        strokeWidth: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.845,
                    left: constraints.maxWidth * 0.425,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'Down',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.4735,
                    left: constraints.maxWidth * 0.625,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.053,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:Right'),
                      child: line(
                        startPoint: const Offset(0, 0.5),
                        endPoint: const Offset(1, 0.5),
                        color: const Color(0xFFFB8F48),
                        strokeWidth: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.46,
                    left: constraints.maxWidth * 0.845,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'Right',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.4735,
                    left: constraints.maxWidth * 0.175,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.053,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:Left'),
                      child: line(
                        startPoint: const Offset(0, 0.5),
                        endPoint: const Offset(1, 0.5),
                        color: const Color(0xFFFB8F48),
                        strokeWidth: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.46,
                    left: constraints.maxWidth * 0.005,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'Left',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.175,
                    left: constraints.maxWidth * 0.625,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.2,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:UR'),
                      child: CustomPaint(painter: UpRight()),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.135,
                    left: constraints.maxWidth * 0.785,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'UR',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.625,
                    left: constraints.maxWidth * 0.625,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.2,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:DR'),
                      child: CustomPaint(painter: DownRight()),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.785,
                    left: constraints.maxWidth * 0.785,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'DR',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.625,
                    left: constraints.maxWidth * 0.175,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.2,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:DL'),
                      child: CustomPaint(painter: DownLeft()),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.785,
                    left: constraints.maxWidth * 0.065,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'DL',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.175,
                    left: constraints.maxWidth * 0.175,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.2,
                    child: GestureDetector(
                      onTap: () => sendMessage('3:UL'),
                      child: CustomPaint(painter: UpLeft()),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.135,
                    left: constraints.maxWidth * 0.065,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        'UL',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
    if (showServo1) {
      double rad = (servoAngle1 - 90) * pi / 180.0;
      generatedChildren.add(
        Container(
          key: const ValueKey(4),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight * 0.04;
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.1,
                    left: constraints.maxWidth * 0.1,
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.4,
                    child: Stack(
                      children: [
                        arc(
                          center: const Offset(0.5, 1),
                          height: 2,
                          width: 1,
                          color: const Color(0xFFFB8F48),
                        ),
                        line(
                          startPoint: const Offset(0.015, 0.99),
                          endPoint: const Offset(0.065, 0.99),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.155, 0.31),
                          endPoint: const Offset(0.195, 0.39),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.5, 0.03),
                          endPoint: const Offset(0.5, 0.13),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.845, 0.31),
                          endPoint: const Offset(0.805, 0.39),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.985, 0.99),
                          endPoint: const Offset(0.935, 0.99),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Transform.rotate(
                              angle: rad,
                              origin: Offset(
                                constraints.maxWidth * 0.5,
                                constraints.maxHeight * 1,
                              ),
                              child: triangle(
                                firstPoint: const Offset(0.49, 0.99),
                                secondPoint: const Offset(0.51, 0.99),
                                thirdPoint: const Offset(0.5, 0.03),
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.44,
                    left: constraints.maxWidth * 0,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '0',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.145,
                    left: constraints.maxWidth * 0.12,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '45',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0,
                    left: constraints.maxWidth * 0.46,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '90',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.145,
                    left: constraints.maxWidth * 0.8,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '135',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.44,
                    left: constraints.maxWidth * 0.92,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '180',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.7,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => setState(() {
                        if (0 <= servoAngle1 && servoAngle1 < 180) {
                          servoAngle1 += 5;
                          generateChildren();
                        }
                      }),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.1,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => setState(() {
                        if (0 < servoAngle1 && servoAngle1 <= 180) {
                          servoAngle1 -= 5;
                          generateChildren();
                        }
                      }),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Icon(Icons.remove, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.35,
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => sendMessage("4:$servoAngle1"),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Text("Send",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF), fontSize: 16)),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
    if (showServo2) {
      double rad = (servoAngle2 - 90) * pi / 180.0;
      generatedChildren.add(
        Container(
          key: const ValueKey(5),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight * 0.04;
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.1,
                    left: constraints.maxWidth * 0.1,
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.4,
                    child: Stack(
                      children: [
                        arc(
                          center: const Offset(0.5, 1),
                          height: 2,
                          width: 1,
                          color: const Color(0xFFFB8F48),
                        ),
                        line(
                          startPoint: const Offset(0.015, 0.99),
                          endPoint: const Offset(0.065, 0.99),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.155, 0.31),
                          endPoint: const Offset(0.195, 0.39),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.5, 0.03),
                          endPoint: const Offset(0.5, 0.13),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.845, 0.31),
                          endPoint: const Offset(0.805, 0.39),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.985, 0.99),
                          endPoint: const Offset(0.935, 0.99),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Transform.rotate(
                              angle: rad,
                              origin: Offset(
                                constraints.maxWidth * 0.5,
                                constraints.maxHeight * 1,
                              ),
                              child: triangle(
                                firstPoint: const Offset(0.49, 0.99),
                                secondPoint: const Offset(0.51, 0.99),
                                thirdPoint: const Offset(0.5, 0.03),
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.44,
                    left: constraints.maxWidth * 0,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '0',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.145,
                    left: constraints.maxWidth * 0.12,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '45',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0,
                    left: constraints.maxWidth * 0.46,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '90',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.145,
                    left: constraints.maxWidth * 0.8,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '135',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.44,
                    left: constraints.maxWidth * 0.92,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '180',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.7,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => setState(() {
                        if (0 <= servoAngle2 && servoAngle2 < 180) {
                          servoAngle2 += 5;
                          generateChildren();
                        }
                      }),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.1,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => setState(() {
                        if (0 < servoAngle2 && servoAngle2 <= 180) {
                          servoAngle2 -= 5;
                          generateChildren();
                        }
                      }),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Icon(Icons.remove, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.35,
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => sendMessage("5:$servoAngle2"),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Text("Send",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF), fontSize: 16)),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
    if (showServo3) {
      double rad = (servoAngle3 - 90) * pi / 180.0;
      generatedChildren.add(
        Container(
          key: const ValueKey(6),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxHeight * 0.04;
              return Stack(
                children: [
                  Positioned(
                    top: constraints.maxHeight * 0.1,
                    left: constraints.maxWidth * 0.1,
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxHeight * 0.4,
                    child: Stack(
                      children: [
                        arc(
                          center: const Offset(0.5, 1),
                          height: 2,
                          width: 1,
                          color: const Color(0xFFFB8F48),
                        ),
                        line(
                          startPoint: const Offset(0.015, 0.99),
                          endPoint: const Offset(0.065, 0.99),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.155, 0.31),
                          endPoint: const Offset(0.195, 0.39),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.5, 0.03),
                          endPoint: const Offset(0.5, 0.13),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.845, 0.31),
                          endPoint: const Offset(0.805, 0.39),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        line(
                          startPoint: const Offset(0.985, 0.99),
                          endPoint: const Offset(0.935, 0.99),
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Transform.rotate(
                              angle: rad,
                              origin: Offset(
                                constraints.maxWidth * 0.5,
                                constraints.maxHeight * 1,
                              ),
                              child: triangle(
                                firstPoint: const Offset(0.49, 0.99),
                                secondPoint: const Offset(0.51, 0.99),
                                thirdPoint: const Offset(0.5, 0.03),
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.44,
                    left: constraints.maxWidth * 0,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '0',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.145,
                    left: constraints.maxWidth * 0.12,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '45',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0,
                    left: constraints.maxWidth * 0.46,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '90',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.145,
                    left: constraints.maxWidth * 0.8,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '135',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.44,
                    left: constraints.maxWidth * 0.92,
                    width: constraints.maxWidth * 0.08,
                    height: constraints.maxHeight * 0.08,
                    child: Center(
                      child: Text(
                        '180',
                        style: TextStyle(fontSize: fontSize),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.7,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => setState(() {
                        if (0 <= servoAngle3 && servoAngle3 < 180) {
                          servoAngle3 += 5;
                          generateChildren();
                        }
                      }),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Icon(Icons.add, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.1,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => setState(() {
                        if (0 < servoAngle3 && servoAngle3 <= 180) {
                          servoAngle3 -= 5;
                          generateChildren();
                        }
                      }),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Icon(Icons.remove, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.7,
                    left: constraints.maxWidth * 0.35,
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () => sendMessage("6:$servoAngle3"),
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Text("Send",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF), fontSize: 16)),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }
    if (showBuzzer) {
      generatedChildren.add(
        Container(
          key: const ValueKey(7),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  line(
                    startPoint: const Offset(0.3, 0.35),
                    endPoint: const Offset(0.7, 0.35),
                    color: Colors.black,
                    strokeWidth: constraints.maxHeight * 0.3,
                  ),
                  line(
                    startPoint: const Offset(0.35, 0.48),
                    endPoint: const Offset(0.35, 0.7),
                    color: Colors.grey,
                    strokeWidth: constraints.maxHeight * 0.03,
                  ),
                  line(
                    startPoint: const Offset(0.65, 0.48),
                    endPoint: const Offset(0.65, 0.7),
                    color: Colors.grey,
                    strokeWidth: constraints.maxHeight * 0.03,
                  ),
                  if (isPressed) ...[
                    line(
                      startPoint: const Offset(0.75, 0.25),
                      endPoint: const Offset(0.9, 0.25),
                      color: const Color(0xFFE0E0E0),
                      strokeWidth: constraints.maxHeight * 0.015,
                    ),
                    line(
                      startPoint: const Offset(0.65, 0.15),
                      endPoint: const Offset(0.75, 0.05),
                      color: const Color(0xFFE0E0E0),
                      strokeWidth: constraints.maxHeight * 0.015,
                    ),
                    line(
                      startPoint: const Offset(0.5, 0),
                      endPoint: const Offset(0.5, 0.15),
                      color: const Color(0xFFE0E0E0),
                      strokeWidth: constraints.maxHeight * 0.015,
                    ),
                    line(
                      startPoint: const Offset(0.35, 0.15),
                      endPoint: const Offset(0.25, 0.05),
                      color: const Color(0xFFE0E0E0),
                      strokeWidth: constraints.maxHeight * 0.015,
                    ),
                    line(
                      startPoint: const Offset(0.1, 0.25),
                      endPoint: const Offset(0.25, 0.25),
                      color: const Color(0xFFE0E0E0),
                      strokeWidth: constraints.maxHeight * 0.015,
                    ),
                  ],
                  Positioned(
                    top: constraints.maxHeight * 0.8,
                    left: constraints.maxWidth * 0.325,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () {
                        sendMessage("7:0");
                        isPressed = false;
                        generateChildren();
                      },
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Text("0",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF), fontSize: 16)),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.8,
                    left: constraints.maxWidth * 0.525,
                    width: constraints.maxWidth * 0.15,
                    height: constraints.maxHeight * 0.15,
                    child: FloatingActionButton(
                      onPressed: () {
                        sendMessage("7:1");
                        isPressed = true;
                        generateChildren();
                      },
                      backgroundColor: const Color(0xFFFB8F48),
                      child: const Text("1",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF), fontSize: 16)),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
    if (showUltrasonic1) {
      generatedChildren.add(
        Container(
          key: const ValueKey(8),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxWidth * 0.12;
              return Center(
                child: Container(
                  height: constraints.maxHeight * 0.3,
                  width: constraints.maxWidth * 1,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFFB8F48),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: TextField(
                      readOnly: true,
                      enableInteractiveSelection: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: const Color(0xFFFB8F48),
                      ),
                      controller: TextEditingController(
                          text: 'Distance: $messageUltrasonic1'),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    if (showUltrasonic2) {
      int msg = int.parse(messageUltrasonic2);
      generatedChildren.add(
        Container(
          key: const ValueKey(9),
          color: Colors.transparent,
          child: Stack(
            children: [
              if (msg > 100)
                arc(
                  center: const Offset(0.5, 0.4),
                  height: 0.4,
                  width: 0.8,
                  color: const Color(0xFF00FF00),
                ),
              if (msg > 75)
                arc(
                  center: const Offset(0.5, 0.475),
                  height: 0.3,
                  width: 0.6,
                  color: const Color(0xFFFFF000),
                ),
              if (msg > 50)
                arc(
                  center: const Offset(0.5, 0.55),
                  height: 0.2,
                  width: 0.4,
                  color: const Color(0xFFFB8F48),
                ),
              if (msg > 10)
                arc(
                  center: const Offset(0.5, 0.625),
                  height: 0.1,
                  width: 0.2,
                  color: const Color(0xFFFF7000),
                ),
              circle(
                centerX: 0.5,
                centerY: 0.7,
                radius: 0.05,
                fill: true,
                color: const Color(0xFFFF0000),
              ),
            ],
          ),
        ),
      );
    }
    if (showDisplay) {
      generatedChildren.add(
        Container(
          key: const ValueKey(10),
          color: Colors.transparent,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fontSize = constraints.maxWidth * 0.12;
              return Stack(
                children: [
                  Center(
                    child: Container(
                      height: constraints.maxHeight * 0.6,
                      width: constraints.maxWidth * 0.85,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFB8F48),
                          width: 10,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TextField(
                          readOnly: true,
                          enableInteractiveSelection: false,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSize,
                            color: const Color(0xFFFB8F48),
                          ),
                          controller:
                              TextEditingController(text: messageDisplay),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  line(
                    startPoint: const Offset(0.65, 0.21),
                    endPoint: const Offset(0.7, 0.1),
                    color: const Color(0xFFFB8F48),
                    strokeWidth: 4,
                  ),
                  circle(
                    centerX: 0.705,
                    centerY: 0.08,
                    radius: 0.02,
                    color: const Color(0xFFFB8F48),
                    strokeWidth: 4,
                  ),
                  line(
                    startPoint: const Offset(0.35, 0.21),
                    endPoint: const Offset(0.3, 0.1),
                    color: const Color(0xFFFB8F48),
                    strokeWidth: 4,
                  ),
                  circle(
                    centerX: 0.295,
                    centerY: 0.08,
                    radius: 0.02,
                    color: const Color(0xFFFB8F48),
                    strokeWidth: 4,
                  ),
                  arc(
                    center: const Offset(0.925, 0.5),
                    height: 0.1,
                    width: 0.075,
                    color: const Color(0xFFFB8F48),
                    start: -pi / 2,
                    sweep: pi,
                    strokeWidth: 4,
                  ),
                  arc(
                    center: const Offset(0.075, 0.5),
                    height: 0.1,
                    width: 0.075,
                    color: const Color(0xFFFB8F48),
                    start: -pi / 2,
                    sweep: -pi,
                    strokeWidth: 4,
                  ),
                  triangle(
                    firstPoint: const Offset(0.66, 0.8),
                    secondPoint: const Offset(0.74, 0.92),
                    thirdPoint: const Offset(0.71, 0.8),
                  ),
                  triangle(
                    firstPoint: const Offset(0.34, 0.8),
                    secondPoint: const Offset(0.26, 0.92),
                    thirdPoint: const Offset(0.29, 0.8),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
    if (showGyro) {
      double msg = double.parse(messageGyro);
      double rad = msg * -pi / 180.0;
      generatedChildren.add(
        Container(
          key: const ValueKey(11),
          color: Colors.transparent,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFFB8F48),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Transform.rotate(
                        angle: rad,
                        origin: Offset(
                          constraints.maxWidth * 0.5,
                          constraints.maxHeight * 0.5,
                        ),
                        child: line(
                          startPoint: const Offset(0.2, 0.5),
                          endPoint: const Offset(0.8, 0.5),
                          color: const Color(0xFFC00000),
                        ),
                      );
                    },
                  ),
                  line(
                      startPoint: const Offset(0, 0.5),
                      endPoint: const Offset(0.2, 0.5),
                      color: const Color(0xFFFB8F48)),
                  line(
                      startPoint: const Offset(0.8, 0.5),
                      endPoint: const Offset(1, 0.5),
                      color: const Color(0xFFFB8F48)),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return generatedChildren;
  }

  void sendMessage(String text) async {
    text = text.trim();
    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode("$text\n")));
        await connection?.output.allSent;
      } catch (e) {
        setState(() {});
      }
    }
  }

  void readMessage() {
    connection!.input?.listen(
      (Uint8List data) {
        String receivedData = utf8.decode(data).trim();
        if (partialData.isNotEmpty) {
          receivedData = partialData + receivedData;
          partialData = '';
        }
        if (receivedData.contains('\n')) {
          receivedData = receivedData.split('\n').first;
        }
        List<String> parts = receivedData.split(':');
        if (parts.length == 2) {
          String id = parts[0];
          String data = parts[1];
          setState(() {
            message(id, data);
            generatedChildren = generateChildren();
          });
        } else {
          partialData = receivedData;
        }
      },
    );
  }

  void message(String id, String data) {
    setState(
      () {
        if (id == '1') {
          if (showDC1) {
            messageIR1 = data;
          }
        } else if (id == '2') {
          if (showDC2) {
            messageIR2 = data;
          }
        } else if (id == '8') {
          if (showUltrasonic1) {
            messageUltrasonic1 = data;
          }
          if (showUltrasonic2) {
            messageUltrasonic2 = data;
          }
        } else if (id == '9') {
          if (showDisplay) {
            messageDisplay = data;
          }
        } else if (id == '10') {
          if (showGyro) {
            messageGyro = data;
          }
        }
      },
    );
  }

  void reorder(List<OrderUpdateEntity> onReorderList) {
    for (final reorder in onReorderList) {
      final draggedItem = generatedChildren[reorder.oldIndex];
      generatedChildren.removeAt(reorder.oldIndex);
      generatedChildren.insert(reorder.newIndex, draggedItem);
    }
    setState(() {});
  }

  Widget reordering() {
    return ReorderableBuilder(
      key: Key(gridViewKey.toString()),
      onReorder: reorder,
      builder: (children) {
        return GridView.count(
          key: gridViewKey,
          crossAxisCount: widgets == 1 ? 1 : 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 8,
          children: children,
        );
      },
      children: generatedChildren,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isConnecting
            ? Text(
                'Connecting to ${widget.device!.name} ...',
                style: const TextStyle(color: Color(0xFFFFFFFF)),
              )
            : Text(
                'Connected to ${widget.device!.name}',
                style: const TextStyle(color: Color(0xFFFFFFFF)),
              ),
        backgroundColor: const Color(0xFFFB8F48),
      ),
      body: Column(
        children: [
          Expanded(child: reordering()),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (generatedChildren.isNotEmpty) {
                    generatedChildren.removeLast();
                    generateChildren().removeLast();
                    if (generatedChildren.length == 1) {
                      widgets = 1;
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                minimumSize: const Size(0, 0),
                fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.1,
                  MediaQuery.of(context).size.height * 0.05,
                ),
                padding: EdgeInsets.zero,
              ),
              child:
                  const Icon(Icons.delete, color: Color(0xFFFB8F48), size: 34),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.7,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.127,
              child: const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFFB8F48)),
                child: Text('Cubes',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24)),
              ),
            ),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/dc motor.png'),
                  radius: 30,
                ),
                title: const Text('DC Motor',
                    style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                trailing: Icon(
                    isExpanded1 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: const Color(0xFF3B82F6)),
                onExpansionChanged: (expanded) {
                  setState(() {
                    isExpanded1 = expanded;
                  });
                },
                children: [
                  if (isExpanded1) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/dc.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Motor 1',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showDC1 == false) widgets++;
                                showDC1 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 1',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/dc.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Motor 2',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showDC2 == false) widgets++;
                                showDC2 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 2',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Stack(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('images/car.png'),
                    radius: 30,
                  ),
                  title: const Text('Car',
                      style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                  onTap: () {
                    setState(() {
                      if (showCar == false) widgets++;
                      showCar = true;
                      generatedChildren = generateChildren();
                    });
                  },
                ),
                const Positioned(
                  bottom: 0,
                  right: 10,
                  child: Text(
                    'id = 3',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/servo.png'),
                  radius: 30,
                ),
                title: const Text('Servo Motor',
                    style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                trailing: Icon(
                    isExpanded2 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: const Color(0xFF3B82F6)),
                onExpansionChanged: (expanded) {
                  setState(() {
                    isExpanded2 = expanded;
                  });
                },
                children: [
                  if (isExpanded2) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/servo.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Motor 1',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showServo1 == false) widgets++;
                                showServo1 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 4',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/servo.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Motor 2',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showServo2 == false) widgets++;
                                showServo2 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 5',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/servo.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Motor 3',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showServo3 == false) widgets++;
                                showServo3 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 6',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Stack(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('images/buzzer.png'),
                    radius: 30,
                  ),
                  title: const Text('Buzzer',
                      style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                  onTap: () {
                    setState(
                      () {
                        if (showBuzzer == false) widgets++;
                        showBuzzer = true;
                        generatedChildren = generateChildren();
                      },
                    );
                  },
                ),
                const Positioned(
                  bottom: 0,
                  right: 10,
                  child: Text(
                    'id = 7',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/ultrasonic.png'),
                  radius: 30,
                ),
                title: const Text('Ultrasonic',
                    style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                trailing: Icon(
                    isExpanded3 ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: const Color(0xFF3B82F6)),
                onExpansionChanged: (expanded) {
                  setState(() {
                    isExpanded3 = expanded;
                  });
                },
                children: [
                  if (isExpanded3) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/reader.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Reader',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showUltrasonic1 == false) widgets++;
                                showUltrasonic1 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 8',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('images/signal.png'),
                              radius: 30,
                            ),
                            title: const Text(
                              'Signal',
                              style: TextStyle(
                                  color: Color(0xFF3B82F6), fontSize: 20),
                            ),
                            onTap: () {
                              setState(() {
                                if (showUltrasonic2 == false) widgets++;
                                showUltrasonic2 = true;
                                generatedChildren = generateChildren();
                              });
                            },
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Text(
                              'id = 8',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Stack(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('images/display.png'),
                    radius: 30,
                  ),
                  title: const Text('OLED Display',
                      style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                  onTap: () {
                    setState(
                      () {
                        if (showDisplay == false) widgets++;
                        showDisplay = true;
                        generatedChildren = generateChildren();
                      },
                    );
                  },
                ),
                const Positioned(
                  bottom: 0,
                  right: 10,
                  child: Text(
                    'id = 9',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Stack(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('images/gyroscope.png'),
                    radius: 30,
                  ),
                  title: const Text('Gyroscope',
                      style: TextStyle(color: Color(0xFF3B82F6), fontSize: 20)),
                  onTap: () {
                    setState(() {
                      if (showGyro == false) widgets++;
                      showGyro = true;
                      generatedChildren = generateChildren();
                    });
                  },
                ),
                const Positioned(
                  bottom: 0,
                  right: 10,
                  child: Text(
                    'id = 10',
                    style: TextStyle(color: Colors.black, fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
