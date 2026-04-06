import 'package:flutter/animation.dart';

/// Pure design tokens — no Theme dependency. Reused across the app so we can
/// retune spacing, radius, motion, and elevation in one place.
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

class AppRadius {
  AppRadius._();
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
}

class AppDurations {
  AppDurations._();
  static const Duration xs = Duration(milliseconds: 120);
  static const Duration sm = Duration(milliseconds: 200);
  static const Duration md = Duration(milliseconds: 320);
  static const Duration lg = Duration(milliseconds: 480);
  static const Duration xl = Duration(milliseconds: 640);
}

class AppCurves {
  AppCurves._();
  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Cubic(0.2, 0, 0, 1);
}

class AppSpring {
  AppSpring._();
  static final SpringDescription gentle = SpringDescription(
    mass: 1,
    stiffness: 180,
    damping: 20,
  );
}

class AppElevation {
  AppElevation._();
  static const double card = 0;
  static const double fab = 6;
  static const double sheet = 1;
}
