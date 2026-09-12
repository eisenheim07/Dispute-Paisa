import 'package:flutter/material.dart';

import 'app_responsive.dart';

class AppConstants {
  // ── Raw values ──────────────────────────────────────────────
  static const double xs = 2;
  static const double sm = 4;
  static const double md = 8;
  static const double lg = 16;
  static const double xl = 32;

  // ── Vertical SizedBoxes ─────────────────────────────────────
  /// 2 dp vertical gap
  static SizedBox get vXS => SizedBox(height: AppResponsive.h(xs));

  /// 4 dp vertical gap
  static SizedBox get vSM => SizedBox(height: AppResponsive.h(sm));

  /// 8 dp vertical gap
  static SizedBox get vMD => SizedBox(height: AppResponsive.h(md));

  /// 16 dp vertical gap
  static SizedBox get vLG => SizedBox(height: AppResponsive.h(lg));

  /// 32 dp vertical gap
  static SizedBox get vXL => SizedBox(height: AppResponsive.h(xl));

  // ── Horizontal SizedBoxes ───────────────────────────────────
  /// 2 dp horizontal gap
  static SizedBox get hXS => SizedBox(width: AppResponsive.w(xs));

  /// 4 dp horizontal gap
  static SizedBox get hSM => SizedBox(width: AppResponsive.w(sm));

  /// 8 dp horizontal gap
  static SizedBox get hMD => SizedBox(width: AppResponsive.w(md));

  /// 16 dp horizontal gap
  static SizedBox get hLG => SizedBox(width: AppResponsive.w(lg));

  /// 32 dp horizontal gap
  static SizedBox get hXL => SizedBox(width: AppResponsive.w(xl));
}
