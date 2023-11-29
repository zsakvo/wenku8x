import 'package:flutter/material.dart';

class BookPageShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    LinearGradient gradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFF908982), Color(0xFFDDD5CB)], // 渐变颜色
    );

    var path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width + 6, size.height)
      ..lineTo(size.width + 6, 0)
      ..close();

    var paint = Paint()
      ..color = const Color(0xff908982) // 阴影颜色和透明度
      ..style = PaintingStyle.fill
      ..shader = gradient.createShader(path.getBounds());

    canvas.drawShadow(path, Colors.black, 4, true); // 绘制阴影
    canvas.drawPath(path, paint); // 绘制路径
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
