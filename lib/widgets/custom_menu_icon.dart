import 'package:flutter/material.dart';

class CustomMenuIcon extends StatelessWidget {
  final String menuId;
  final Color color;
  final double size;

  const CustomMenuIcon({
    super.key,
    required this.menuId,
    required this.color,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _getIconPainter(menuId, color),
    );
  }

  CustomPainter _getIconPainter(String id, Color color) {
    switch (id) {
      case '1': // Contract Performance
        return ContractPerformanceIconPainter(color);
      case '2': // Waste Management
        return WasteManagementIconPainter(color);
      case '3': // Cleaning
        return CleaningIconPainter(color);
      case '4': // Compliance
        return ComplianceIconPainter(color);
      case '5': // Technical Services
        return TechnicalIconPainter(color);
      case '6': // Spaces
        return SpacesIconPainter(color);
      case '7': // Wellbeing
        return WellbeingIconPainter(color);
      default:
        return ContractPerformanceIconPainter(color);
    }
  }
}

// Contract Performance Icon (Document with user)
class ContractPerformanceIconPainter extends CustomPainter {
  final Color color;
  ContractPerformanceIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Document rectangle
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.15, size.height * 0.1, size.width * 0.6, size.height * 0.7),
      const Radius.circular(4),
    );
    canvas.drawRRect(rect, paint);

    // Lines in document
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.3),
      Offset(size.width * 0.65, size.height * 0.3),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.25, size.height * 0.45),
      Offset(size.width * 0.65, size.height * 0.45),
      paint,
    );

    // User icon (circle + body)
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.65),
      size.width * 0.08,
      paint,
    );
    
    final path = Path();
    path.moveTo(size.width * 0.67, size.height * 0.85);
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.75,
      size.width * 0.83, size.height * 0.85,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Waste Management Icon (Recycling symbol)
class WasteManagementIconPainter extends CustomPainter {
  final Color color;
  WasteManagementIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Draw recycling triangular arrows
    final path1 = Path();
    path1.moveTo(size.width * 0.5, size.height * 0.2);
    path1.lineTo(size.width * 0.35, size.height * 0.5);
    path1.lineTo(size.width * 0.25, size.height * 0.45);
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(size.width * 0.35, size.height * 0.5);
    path2.lineTo(size.width * 0.65, size.height * 0.5);
    path2.lineTo(size.width * 0.6, size.height * 0.65);
    canvas.drawPath(path2, paint);

    final path3 = Path();
    path3.moveTo(size.width * 0.65, size.height * 0.5);
    path3.lineTo(size.width * 0.5, size.height * 0.2);
    path3.lineTo(size.width * 0.6, size.height * 0.15);
    canvas.drawPath(path3, paint);

    // Arrows
    paint.style = PaintingStyle.fill;
    final arrow1 = Path();
    arrow1.moveTo(size.width * 0.25, size.height * 0.45);
    arrow1.lineTo(size.width * 0.22, size.height * 0.48);
    arrow1.lineTo(size.width * 0.28, size.height * 0.48);
    canvas.drawPath(arrow1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Cleaning Icon (Broom)
class CleaningIconPainter extends CustomPainter {
  final Color color;
  CleaningIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Broom handle
    canvas.drawLine(
      Offset(size.width * 0.6, size.height * 0.2),
      Offset(size.width * 0.3, size.height * 0.6),
      paint,
    );

    // Broom bristles (oval shape)
    final bristlePath = Path();
    bristlePath.addOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.35, size.height * 0.7),
        width: size.width * 0.25,
        height: size.height * 0.3,
      ),
    );
    
    // Rotate the oval
    final matrix = Matrix4.identity();
    matrix.translate(size.width * 0.35, size.height * 0.7);
    matrix.rotateZ(-0.5);
    matrix.translate(-size.width * 0.35, -size.height * 0.7);
    
    canvas.drawPath(bristlePath.transform(matrix.storage), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Compliance Icon (Checkmarks with lines)
class ComplianceIconPainter extends CustomPainter {
  final Color color;
  ComplianceIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Three checkmarks with lines
    for (int i = 0; i < 3; i++) {
      double y = size.height * (0.25 + i * 0.25);
      
      // Checkmark
      final checkPath = Path();
      checkPath.moveTo(size.width * 0.2, y);
      checkPath.lineTo(size.width * 0.3, y + size.height * 0.08);
      checkPath.lineTo(size.width * 0.45, y - size.height * 0.05);
      canvas.drawPath(checkPath, paint);
      
      // Line
      canvas.drawLine(
        Offset(size.width * 0.55, y),
        Offset(size.width * 0.8, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Technical Icon (Gears)
class TechnicalIconPainter extends CustomPainter {
  final Color color;
  TechnicalIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // First gear
    _drawGear(canvas, Offset(size.width * 0.35, size.height * 0.4), size.width * 0.15, paint);
    
    // Second gear (smaller, overlapping)
    _drawGear(canvas, Offset(size.width * 0.6, size.height * 0.6), size.width * 0.12, paint);
  }

  void _drawGear(Canvas canvas, Offset center, double radius, Paint paint) {
    // Outer circle with teeth
    const teeth = 8;
    final path = Path();
    
    for (int i = 0; i < teeth; i++) {
      double angle1 = (i * 2 * 3.14159) / teeth;
      double angle2 = ((i + 0.4) * 2 * 3.14159) / teeth;
      double angle3 = ((i + 0.6) * 2 * 3.14159) / teeth;
      
      if (i == 0) {
        path.moveTo(
          center.dx + radius * 1.2 * cos(angle1),
          center.dy + radius * 1.2 * sin(angle1),
        );
      }
      
      path.lineTo(
        center.dx + radius * 1.2 * cos(angle2),
        center.dy + radius * 1.2 * sin(angle2),
      );
      path.lineTo(
        center.dx + radius * cos(angle2),
        center.dy + radius * sin(angle2),
      );
      path.lineTo(
        center.dx + radius * cos(angle3),
        center.dy + radius * sin(angle3),
      );
      path.lineTo(
        center.dx + radius * 1.2 * cos(angle3),
        center.dy + radius * 1.2 * sin(angle3),
      );
    }
    
    path.close();
    canvas.drawPath(path, paint);
    
    // Inner circle
    canvas.drawCircle(center, radius * 0.4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Spaces Icon (Grid/Blocks)
class SpacesIconPainter extends CustomPainter {
  final Color color;
  SpacesIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Draw 2x2 grid
    final blockSize = size.width * 0.18;
    final spacing = size.width * 0.08;
    
    for (int row = 0; row < 2; row++) {
      for (int col = 0; col < 2; col++) {
        final rect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.width * 0.25 + col * (blockSize + spacing),
            size.height * 0.3 + row * (blockSize + spacing),
            blockSize,
            blockSize,
          ),
          const Radius.circular(4),
        );
        canvas.drawRRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Wellbeing Icon (Smiley face)
class WellbeingIconPainter extends CustomPainter {
  final Color color;
  WellbeingIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Face circle
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.3,
      paint,
    );

    // Eyes
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.42),
      size.width * 0.03,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.6, size.height * 0.42),
      size.width * 0.03,
      paint,
    );

    // Smile
    paint.style = PaintingStyle.stroke;
    final smilePath = Path();
    smilePath.moveTo(size.width * 0.35, size.height * 0.55);
    smilePath.quadraticBezierTo(
      size.width * 0.5, size.height * 0.65,
      size.width * 0.65, size.height * 0.55,
    );
    canvas.drawPath(smilePath, paint);

    // Sparkle (star)
    paint.strokeWidth = 2.0;
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.25),
      Offset(size.width * 0.75, size.height * 0.35),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.3),
      Offset(size.width * 0.8, size.height * 0.3),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

double cos(double angle) => (angle * 180 / 3.14159).toDouble();
double sin(double angle) => (angle * 180 / 3.14159).toDouble();