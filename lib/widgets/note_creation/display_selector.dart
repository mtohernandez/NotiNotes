import 'package:flutter/material.dart';

import '../../widgets/items/icon_button_x_item.dart';

class DisplaySelector extends StatefulWidget {
  final String id;
  const DisplaySelector(this.id, {super.key});

  @override
  State<DisplaySelector> createState() => _DisplaySelectorState();
}

class _DisplaySelectorState extends State<DisplaySelector> {
  void exitCreator() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Display mode',
                style: Theme.of(context).textTheme.headline1,
              ),
              IconButtonXItem(exitCreator),
            ],
          ),
          // Display selector here
        ],
      ),
    );
  }
}
