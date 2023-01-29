import 'package:flutter/material.dart';


class BottomSheetItem extends StatelessWidget {
  final Widget child;
  final bool bottomInsets;
  const BottomSheetItem(this.child, this.bottomInsets, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
            bottom:
                bottomInsets ? MediaQuery.of(context).viewInsets.bottom : 20,
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),
          child: child,
        )
      ],
    );
  }
}