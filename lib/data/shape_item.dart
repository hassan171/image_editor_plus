import 'package:flutter/material.dart';

enum ShapeType {
  circle,
  square,
  triangle,
  arrow;

  static ShapeType fromName(String name) {
    return ShapeType.values.firstWhere((e) => e.name == name);
  }

  //get shape widget
  Widget build({
    required Color color,
    required bool filled,
    required double size,
  }) {
    switch (this) {
      case ShapeType.circle:
        return CustomPaint(
          painter: CirclePainter(color, size, filled: filled),
          size: Size(size, size),
        );
      case ShapeType.square:
        return CustomPaint(
          painter: SquarePainter(color, size, filled: filled),
          size: Size(size, size),
        );
      case ShapeType.triangle:
        return CustomPaint(
          painter: TrianglePainter(color, size, filled: filled),
          size: Size(size, size),
        );
      case ShapeType.arrow:
        return CustomPaint(
          painter: ArrowPainter(color, size, filled: filled),
          size: Size(size, size),
        );
    }
  }
}

//circle shape using custom painter
class CirclePainter extends CustomPainter {
  final Color color;
  final double size;
  final bool filled;

  CirclePainter(
    this.color,
    this.size, {
    this.filled = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), this.size, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//square shape using custom painter
class SquarePainter extends CustomPainter {
  final Color color;
  final double size;
  final bool filled;

  SquarePainter(
    this.color,
    this.size, {
    this.filled = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    canvas.drawRect(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: this.size, height: this.size), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//triangle shape using custom painter
class TrianglePainter extends CustomPainter {
  final Color color;
  final double size;
  final bool filled;

  TrianglePainter(
    this.color,
    this.size, {
    this.filled = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = filled ? PaintingStyle.fill : PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//arrow shape using custom painter
class ArrowPainter extends CustomPainter {
  final Color color;
  final double size;
  final bool filled;

  ArrowPainter(
    this.color,
    this.size, {
    this.filled = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();

    //first draw thinner triangle
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width * 3 / 4, size.height / 2);
    path.lineTo(size.width / 4, size.height / 2);

    //draw thinner rectangle
    path.moveTo(size.width * 2 / 5, size.height / 2);
    path.lineTo(size.width * 3 / 5, size.height / 2);
    path.lineTo(size.width * 3 / 5, size.height * 2);
    path.lineTo(size.width * 2 / 5, size.height * 2);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
