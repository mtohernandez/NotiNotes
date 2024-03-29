import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ColorPicker {
  static Color defaultColor = const Color(0xffEF233C);
  static Color defaultFontColor = Colors.white;

  static List<Color> backgroundColors = [
    Colors.black,
    const Color(0xffF9C100),
    const Color(0xffEF233C),
    const Color(0xff9638CD),
    const Color(0xff5B5DD7),
    const Color(0xff48BFE3),
    const Color(0xff72EFDD),
  ];

  static void updateColors() {}

  static final List<String> patterns = [
    'lib/assets/images/patterns/polygons.png',
    'lib/assets/images/patterns/pureNoisePNG.png',
    'lib/assets/images/patterns/splashesPNG.png',
    'lib/assets/images/patterns/upScaleWavesPNG.png',
    'lib/assets/images/patterns/wavesRegulatedPNG.png',
    'lib/assets/images/patterns/wavesUnregulatedPNG.png',
    'lib/assets/images/patterns/klaeidoscope.png',
  ];

  static final List<Color> fontColors = [
    Colors.white,
    Colors.black,
    const Color(0xffFFE5E5),
    const Color(0xffD2E2FF),
    const Color(0xffFCD9FF),
    const Color(0xffDEFFDB),
  ];

  static final List<LinearGradient> gradients = [
    const LinearGradient(
      colors: [
        Color(0xffF9C100),
        Color(0xffEF233C),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color(0xff9638CD),
        Color(0xff5B5DD7),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    const LinearGradient(
      colors: [
        Color(0xff48BFE3),
        Color(0xff72EFDD),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [
        Color(0xff9638CD),
        Color(0xffEF233C),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [
        Color(0xffF9C100),
        Color(0xff48BFE3),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
    const LinearGradient(
      colors: [
        Color(0xffEF233C),
        Color(0xff48BFE3),
      ],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ];

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
