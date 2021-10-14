import 'dart:ffi';

import 'dart:math';

const fullCorener = 180;

extension MathConverter on double {
  double get convertRadToDeg => this * fullCorener / pi;
  double get convertDegToRad => this * fullCorener / pi;
}
