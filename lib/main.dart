// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Logic/Models/complex.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.purple),
      home: const MandelbrotSet(),
    ));

class MandelbrotSet extends StatefulWidget {
  const MandelbrotSet({Key? key}) : super(key: key);

  @override
  _MandelbrotSet createState() => _MandelbrotSet();
}

class _MandelbrotSet extends State<MandelbrotSet> {
  double zoom = 6;
  bool isVisibleSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mandelbrot Set'),
          backgroundColor: Colors.purple,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isVisibleSet = true;
            });
          },
          child: const Text('Start'),
          backgroundColor: Colors.purple,
        ),
        body: isVisibleSet
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    zoom /= 2;
                  });
                },
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constrains) {
                    return CustomPaint(
                        painter: MyDrawer(scale: zoom),
                        size: Size(constrains.maxWidth, constrains.maxHeight));
                  },
                ),
              )
            : null,
        drawerScrimColor: Colors.blue);
  }
}

class MyDrawer extends CustomPainter {
  final double scale;
  MyDrawer({required this.scale});
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == null || size.height == null) {
      return;
    }
    for (double x = 0; x < size.width; x++) {
      for (double y = 0; y < size.height; y++) {
        int count = 0;
        double _x = (x - size.width / 2.0) / (size.width / scale);
        double _y = (y - size.height / 2.0) / (size.height / scale);
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
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
