import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math' as math;
class MyArc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
    );
  }
}
// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final r = w/ 15;

    Paint paint = Paint()..color = Color(0xffEDEAEA);
    final path = Path();
    Paint paint1 = Paint();
    var rect = Offset.zero & size;
    paint1.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xffFAB121),
        Color(0xff844FDD),
      ],
    ).createShader(rect);

    final path1 = Path();
    Paint paint2 = Paint()..color = Color(0xff22136B);
    final path2 = Path();


    canvas.drawRect(Offset(0, 0) &  Size(w, h/4), paint2);
    canvas.drawRect(Offset(w/6, h/8+30) &  Size(w*(4/6), h/4-30), paint1,);

    Paint paint4 = Paint();
    paint4.shader = LinearGradient(
      // begin: Alignment.topLeft,
      // end: Alignment.topRight,
      colors: [
        Color(0xffdd9850),
        Color(0xffa168ae),
      ],
    ).createShader(rect);
    path1.moveTo(0, h/4);
    path1.arcToPoint(
      Offset(w / 2 + r, size.height/4),
      radius: Radius.elliptical(4, 2),
      clockwise: false,
    );
    canvas.drawPath(path1, paint4);


    path.moveTo(w/2-r, h/4);

    //path.lineTo(w / 2 - r, size.height/2,);
    path.arcToPoint(
      Offset(w / 2 + r, size.height/4),
      radius: Radius.elliptical(4, 2),
      clockwise: false,
    );

    path.lineTo(w, h/4);
    path.lineTo(w, h);

    path.lineTo(0, h);
    path.lineTo(0, h/4);
    path.close();
    canvas.drawPath(path, paint);

    path2.moveTo(w/2-r-1, h/4+1);

    //path.lineTo(w / 2 - r, size.height/2,);
    path2.arcToPoint(
      Offset(w / 2 + r+1, size.height/4+1),
      radius: Radius.elliptical(4, 2),
      clockwise: false,
    );
    path2.lineTo(w, h/4+1);
    path2.lineTo(w, h);

    path2.lineTo(0, h);
    path2.lineTo(0, h/4+1);
    path2.close();
    canvas.drawPath(path2, paint2);


    Paint paint6 = Paint()..maskFilter = MaskFilter.blur(
        BlurStyle.normal, 20.0
    );
    paint6.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xffdd9850),
        Color(0xffa168ae),
      ],
    ).createShader(rect);




    final path5 = Path();

    path5.moveTo(w/2-r-1, h/4+1);

    //path.lineTo(w / 2 - r, size.height/2,);
    path5.arcToPoint(
      Offset(w / 2 + r+1, size.height/4+1),
      radius: Radius.elliptical(4, 2),
      clockwise: false,
    );
    path5.lineTo(5*w/6, h/4+1);
    path5.lineTo(5*w/6, h/4+50);

    path5.lineTo(w/6, h/4+50);
    path5.lineTo(w/6, h/4+1);
    path5.close();
    canvas.drawPath(path5, paint6);


    Paint paint5 = Paint();
    paint5.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
      colors: [
        Color(0x73D0CDCD),
        Color(0x1a928CAA),
      ],
    ).createShader(rect);




    final path4 = Path();

    path4.moveTo(w/2-r-1, h/4+1);

    //path.lineTo(w / 2 - r, size.height/2,);
    path4.arcToPoint(
      Offset(w / 2 + r+1, size.height/4+1),
      radius: Radius.elliptical(4, 2),
      clockwise: false,
    );
    path4.lineTo(w, h/4+1);
    path4.lineTo(w, h);

    path4.lineTo(0, h);
    path4.lineTo(0, h/4+1);
    path4.close();
    canvas.drawPath(path4, paint5);


    final a = Offset(size.width * 1 / 6, size.height * 1 / 8);
    final b = Offset(size.width * 5 / 6, size.height * 1 / 4);
    final rect1 = Rect.fromPoints(a, b);
    final radius = Radius.circular(15);

    canvas.drawRRect(RRect.fromRectAndRadius(rect1, radius), paint1);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}