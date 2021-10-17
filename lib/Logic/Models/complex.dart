import 'dart:math' as math;
import '../Extensions/math_converters.dart';

class Complex {
  static Complex nan = Complex(double.nan, double.nan);
  static Complex infinity = Complex(double.infinity, double.infinity);
  double _x = 0;
  double _y = 0;
  double _corner = 0;
  Complex(double x, double y) {
    _x = x;
    _y = y;
    if (_y != 0) {
      _corner = math.atan(_x / _y);
    }
  }
  bool get isFinite => !isNaN && _x.isFinite && _y.isFinite;
  bool get isInfinite => !isNaN && (_x.isInfinite || _y.isInfinite);
  bool get isNaN => _x.isNaN || _y.isNaN;
  double get corner => _corner.convertRadToDeg;
  double get x => _x;
  double get y => _y;

  double magrnitude() {
    if (isNaN) {
      return double.nan;
    }
    if (isInfinite) {
      return double.infinity;
    }
    if (_x.abs() < _y.abs()) {
      if (_x == 0.0) {
        return _y.abs();
      }
      double q = _x / _y;
      return _y.abs() * math.sqrt(1 + q * q);
    } else {
      if (_y == 0.0) {
        return _x.abs();
      }
      double q = _y / _x;
      return _x.abs() * math.sqrt(1 + q * q);
    }
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
    var z = this;
    if (pow == 0) {
      return Complex(1, 1);
    }
    if (pow > 0) {
      for (int i = 1; i < pow; i++) {
        z = z * z;
      }
      return z;
    }
    var module = math.pow(magrnitude(), pow);
    var x = module * math.cos(_corner);
    var y = module * math.sin(_corner);
    return Complex(x, y);
  }

  Complex operator *(Object value) {
    if (value is Complex) {
      if (isNaN || value.isNaN) {
        return nan;
      }
      if (_x.isInfinite ||
          _y.isInfinite ||
          value._x.isInfinite ||
          value._y.isInfinite) {
        return infinity;
      }
      return Complex(
          _x * value._x - _y * value._y, _x * value._y + _y * value._x);
    } else if (value is num) {
      if (isNaN || value.isNaN) {
        return nan;
      }
      if (_x.isInfinite || _y.isInfinite || value.isInfinite) {
        return infinity;
      }
      return Complex(_x * value, _y * value);
    } else {
      throw ArgumentError('factor must be a num or a Complex');
    }
  }
}
