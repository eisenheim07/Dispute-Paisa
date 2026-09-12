import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResponsive {
  AppResponsive._();

  static const double _wCap = 1.3;
  static const double _hCap = 1.3;
  static const double _rCap = 1.2;
  static const double _spCap = 1.15;

  /// Capped horizontal dimension (replaces .w)
  static double w(double size) {
    final scaled = size.w;
    final max = size * _wCap;
    return scaled > max ? max : scaled;
  }

  /// Capped vertical dimension (replaces .h)
  static double h(double size) {
    final scaled = size.h;
    final max = size * _hCap;
    return scaled > max ? max : scaled;
  }

  /// Capped radius / square dimension (replaces .r)
  static double r(double size) {
    final scaled = size.r;
    final max = size * _rCap;
    return scaled > max ? max : scaled;
  }

  /// Capped font size (replaces .sp)
  static double sp(double size) {
    final scaled = size.sp;
    final max = size * _spCap;
    return scaled > max ? max : scaled;
  }
}
