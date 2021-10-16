import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mondelbrot_set/Logic/Models/complex.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Mandelbrot Set'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Text('Start'),
            ),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constrains) {
                return CustomPaint(
                    painter: MyDrawer(),
                    size: Size(constrains.maxWidth, constrains.maxHeight));
              },
            )));
  }
}

class MyDrawer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /*for (double x = 0; x < size.width; x++) {
      for (double y = 0; y < size.height; y++) {
        int count = 0;
        Complex z = Complex(0, 0);
        Complex c = Complex(x, y);
        for (count = 0; count <= 100; count) {
          z = z ^ 2;
          z = z + c;
          if (z.magrnitude() > 2) break;
        }
        var rect = Offset(x, y) & const Size(1, 1);
        BlendMode blendMode = BlendMode.src;
        var color =
            count < 100 ? Color.fromRGBO(count, count, count, 1) : Colors.white;
        canvas.drawColor(color, blendMode);
      }
    }*/
    var rect = Offset(0, 0) & Size(10, 10);
    final c = Completer<ui.Image>();
    final pixels = Int32List(1024 * 1024);
    for (int i = 0; i < pixels.length; i++) {
      pixels[i] = Colors.red as int;
    }
    ui.decodeImageFromPixels(
      pixels.buffer.asUint8List(),
      1024,
      1024,
      ui.PixelFormat.rgba8888,
      c.complete,
    );
    canvas.drawImage(c.future.s, const Offset(0, 0), Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
