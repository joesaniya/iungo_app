import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IungoLogo extends StatelessWidget {
  final double size;

  const IungoLogo({Key? key, this.size = 80}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(size: Size(size, size * 0.5), painter: IungoLogoPainter()),
        /*  Image.asset(
          'assets/images/iungo-logo.png',
          width: 139.17.w,
          height: 150.h,
          fit: BoxFit.contain,
        ),*/
        SizedBox(height: size * 0.15),
        Text(
          'iungo',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: size * 0.35,
            fontWeight: FontWeight.w700,
            color: AppTheme.black,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: size * 0.05),
        Text(
          'Powered by GIT',
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: size * 0.12,
            fontWeight: FontWeight.w400,
            color: AppTheme.gray,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class IungoLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryRed
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Left loop
    final leftCenter = Offset(size.width * 0.25, size.height * 0.5);
    final leftRadius = size.width * 0.15;

    path.addOval(Rect.fromCircle(center: leftCenter, radius: leftRadius));

    // Right loop
    final rightCenter = Offset(size.width * 0.75, size.height * 0.5);
    final rightRadius = size.width * 0.15;

    path.addOval(Rect.fromCircle(center: rightCenter, radius: rightRadius));

    // Center connection (infinity symbol style)
    final centerPath = Path();
    centerPath.moveTo(size.width * 0.35, size.height * 0.3);

    centerPath.cubicTo(
      size.width * 0.45,
      size.height * 0.15,
      size.width * 0.55,
      size.height * 0.15,
      size.width * 0.65,
      size.height * 0.3,
    );

    centerPath.cubicTo(
      size.width * 0.55,
      size.height * 0.45,
      size.width * 0.45,
      size.height * 0.45,
      size.width * 0.35,
      size.height * 0.3,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(centerPath, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
