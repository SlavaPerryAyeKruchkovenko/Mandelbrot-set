import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Logic/Models/complex.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Mandelbrot Set'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                //myPaint.paint(canvas, size);
              },
              child: const Text('Start'),
            ),
            body: Center(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrains) {
                return CustomPaint(
                    painter: myPaint,
                    size: Size(constrains.maxWidth, constrains.maxHeight));
              },
            ))));
  }
}

CustomPainter? myPaint = MyDrawer();

class MyDrawer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for (double x = 0; x < size.width; x++) {
      for (double y = 0; y < size.height; y++) {
        int count = 0;
        double _x = (x - size.width / 2.0) / (size.width / 6.0);
        double _y = (y - size.height / 2.0) / (size.height / 6.0);
        Complex z = Complex(0, 0);
        Complex c = Complex(_x, _y);

        Complex getComplex(Complex z, Complex c) {
          z = z ^ 2;
          z = z + c;
          count++;
          if (z.magrnitude() > 2 || count >= 100) {
            return z;
          } else {
            return getComplex(z, c);
          }
        }

        z = getComplex(z, c);
        var rect = Offset(x, y) & const Size(1, 1);
        var paint = Paint()
          ..color = count < 100
              ? Color.fromARGB(255, (count * 7) % 255, 0, (count * 7) % 255)
              : Color.fromRGBO(count, count, count, 1);

        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
