import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ColorPicker {
  static Color defaultColor = const Color(0xffEF233C);

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

  static final List<ImageProvider<Object>> patterns = [
    const AssetImage(
      'lib/assets/images/patterns/polygons.png',
    ),
    const AssetImage(
      'lib/assets/images/patterns/pureNoisePNG.png',
    ),
    const AssetImage(
      'lib/assets/images/patterns/splashesPNG.png',
    ),
    const AssetImage(
      'lib/assets/images/patterns/upScaleWavesPNG.png',
    ),
    const AssetImage(
      'lib/assets/images/patterns/wavesRegulatedPNG.png',
    ),
    const AssetImage(
      'lib/assets/images/patterns/wavesUnregulatedPNG.png',
    ),
    const AssetImage(
      'lib/assets/images/patterns/klaeidoscope.png',
    ),
  ];

  static final List<Color> fontColors = [
    Colors.white,
    Colors.black,
    Color(0xffFFE5E5),
    Color(0xffD2E2FF),
    Color(0xffFCD9FF),
    Color(0xffDEFFDB),
  ];
}
