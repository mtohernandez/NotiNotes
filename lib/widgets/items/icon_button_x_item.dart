import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class IconButtonXItem extends StatelessWidget {
  final Function? doSomething;
  const IconButtonXItem(this.doSomething, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45 * math.pi / 180,
      child: IconButton(
        onPressed: () {
          doSomething!();
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(30, 0),
        ),
        icon: SvgPicture.asset(
          'lib/assets/icons/plus.svg',
          color: Theme.of(context).textTheme.bodyText1!.color,
          height: Theme.of(context).textTheme.bodyText1!.fontSize,
        ),
      ),
    );
  }
}
