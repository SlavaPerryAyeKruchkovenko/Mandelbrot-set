import 'dart:math' as math;
import '../Extensions/math_converters.dart';

class Complex {
  final double _x;
  final double _y;
  double _corner = 0;
  Complex(this._x, this._y) {
    _corner = math.atan(_x / _y);
  }

  double get corner => _corner.convertRadToDeg;
  double get x => _x;
  double get y => _y;

  double magrnitude() {
    return math.sqrt(math.pow(_x, 2) + math.pow(_y, 2));
  }

  @override
  String toString() {
    return _y > 0 ? ("$_x + $_y" "i") : ("$_x $_y" "i");
  }

  Complex operator +(Complex otherNum) {
    var x = _x + otherNum.x;
    var y = _y + otherNum.y;
    return Complex(x, y);
  }

  Complex operator ^(int pow) {
    var module = math.pow(magrnitude(), pow);
    var x = module * math.cos(_corner);
    var y = module * math.sin(_corner);
    return Complex(x, y);
  }
}
