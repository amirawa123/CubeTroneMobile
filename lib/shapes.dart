import 'package:flutter/material.dart';
import 'dart:math';

Widget line(
    {required Offset startPoint,
    required Offset endPoint,
    Color? color,
    double? strokeWidth}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final startPointPixel = Offset(
        constraints.maxWidth * startPoint.dx,
        constraints.maxHeight * startPoint.dy,
      );
      final endPointPixel = Offset(
        constraints.maxWidth * endPoint.dx,
        constraints.maxHeight * endPoint.dy,
      );
      return CustomPaint(
        painter: LinePainter(
            startPoint: startPointPixel,
            endPoint: endPointPixel,
            color: color ?? const Color(0xFFAD0000),
            strokeWidth: strokeWidth ?? 10),
      );
    },
  );
}

class LinePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final double strokeWidth;

  LinePainter(
      {required this.startPoint,
      required this.endPoint,
      required this.color,
      required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget circle(
    {required double centerX,
    required double centerY,
    double? radius,
    bool? fill,
    Color? color,
    double? strokeWidth}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final centerXPixel = constraints.maxWidth * centerX;
      final centerYPixel = constraints.maxHeight * centerY;
      final radiusPixel2 = constraints.maxWidth * 0.035;
      final selectedRadius =
          radius != null ? constraints.maxWidth * radius : radiusPixel2;
      return CustomPaint(
        painter: CirclePainter(
          centerX: centerXPixel,
          centerY: centerYPixel,
          radius: selectedRadius,
          fill: fill ?? false,
          color: color ?? const Color(0xFFAD0000),
          strokeWidth: strokeWidth ?? 10,
        ),
      );
    },
  );
}

class CirclePainter extends CustomPainter {
  final double centerX;
  final double centerY;
  final double radius;
  final bool fill;
  final Color color;
  final double strokeWidth;

  CirclePainter(
      {required this.centerX,
      required this.centerY,
      required this.radius,
      required this.fill,
      required this.color,
      required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;
    if (fill) {
      paint.style = PaintingStyle.fill;
    } else {
      paint.style = PaintingStyle.stroke;
    }
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget arc(
    {required center,
    required height,
    required width,
    required Color color,
    double? start,
    double? sweep,
    double? strokeWidth}) {
  return LayoutBuilder(builder: (context, constraints) {
    final rect = Rect.fromCenter(
      center: Offset(
          constraints.maxWidth * center.dx, constraints.maxHeight * center.dy),
      width: constraints.maxWidth * width,
      height: constraints.maxHeight * height,
    );
    return CustomPaint(
        painter: ArcPainter(
      rectSize: rect,
      color: color,
      start: start ?? 0,
      sweep: sweep ?? -pi,
      strokeWidth: strokeWidth ?? 10,
    ));
  });
}

class ArcPainter extends CustomPainter {
  final Rect rectSize;
  final Color color;
  final double start;
  final double sweep;
  final double strokeWidth;

  ArcPainter({
    required this.rectSize,
    required this.color,
    required this.start,
    required this.sweep,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawArc(rectSize, start, sweep, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ClockwiseArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB8F48)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0, size.height * 0);
    path.arcToPoint(
      Offset(size.width * 0.75, size.height * 0.95),
      radius: Radius.circular(size.width),
    );
    path.moveTo(size.width * 0.72, size.height * 0.97);
    path.lineTo(size.width * 1, size.height * 0.6);
    path.moveTo(size.width * 0.8, size.height * 0.96);
    path.lineTo(size.width * 0.38, size.height * 0.65);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CounterClockwiseArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB8F48)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 1, size.height * 0);
    path.arcToPoint(
      Offset(size.width * 0.25, size.height * 0.95),
      radius: Radius.circular(size.width),
      clockwise: false,
    );
    path.moveTo(size.width * 0.28, size.height * 0.97);
    path.lineTo(size.width * 0, size.height * 0.6);
    path.moveTo(size.width * 0.2, size.height * 0.96);
    path.lineTo(size.width * 0.62, size.height * 0.65);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class UpRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB8F48)
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0, size.height * 1);
    path.lineTo(size.width * 0, size.height * 0);
    path.arcToPoint(
      Offset(size.width * 1, size.height * 1),
      radius: Radius.circular(size.width),
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DownRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB8F48)
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 0, size.height * 0);
    path.lineTo(size.width * 1, size.height * 0);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 1),
      radius: Radius.circular(size.width),
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DownLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB8F48)
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 1, size.height * 0);
    path.lineTo(size.width * 1, size.height * 1);
    path.arcToPoint(
      Offset(size.width * 0, size.height * 0),
      radius: Radius.circular(size.width),
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class UpLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFB8F48)
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 1, size.height * 1);
    path.lineTo(size.width * 0, size.height * 1);
    path.arcToPoint(
      Offset(size.width * 1, size.height * 0),
      radius: Radius.circular(size.width),
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget triangle({
  required Offset firstPoint,
  required Offset secondPoint,
  required Offset thirdPoint,
  Color? color,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      firstPoint = Offset(
        constraints.maxWidth * firstPoint.dx,
        constraints.maxHeight * firstPoint.dy,
      );
      secondPoint = Offset(
        constraints.maxWidth * secondPoint.dx,
        constraints.maxHeight * secondPoint.dy,
      );
      thirdPoint = Offset(
        constraints.maxWidth * thirdPoint.dx,
        constraints.maxHeight * thirdPoint.dy,
      );
      return CustomPaint(
        painter: Triangle(
          firstPoint: firstPoint,
          secondPoint: secondPoint,
          thirdPoint: thirdPoint,
          color: color ?? const Color(0xFFFB8F48),
        ),
      );
    },
  );
}

class Triangle extends CustomPainter {
  final Offset firstPoint;
  final Offset secondPoint;
  final Offset thirdPoint;
  final Color color;

  Triangle({
    required this.firstPoint,
    required this.secondPoint,
    required this.thirdPoint,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(firstPoint.dx, firstPoint.dy);
    path.lineTo(secondPoint.dx, secondPoint.dy);
    path.lineTo(thirdPoint.dx, thirdPoint.dy);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
