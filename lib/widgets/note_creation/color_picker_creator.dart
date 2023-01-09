import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as convertion;
import 'package:noti_notes_app/helpers/color_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../../widgets/items/icon_button_x_item.dart';

import '../../providers/notes.dart';
import '../../models/note.dart';

class ColorPickerCreator extends StatefulWidget {
  final String id;
  const ColorPickerCreator(this.id, {super.key});

  @override
  State<ColorPickerCreator> createState() => _ColorPickerCreatorState();
}

class _ColorPickerCreatorState extends State<ColorPickerCreator> {
  late Color selectedColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    selectedColor = Provider.of<Notes>(context).findColor(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);
    final circleShape = MediaQuery.of(context).size.width * 0.1;

    // Note note = notes.findById(widget.id);

    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Color Picker',
                style: Theme.of(context).textTheme.headline1,
              ),
              IconButtonXItem(Navigator.of(context).pop),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Default palette',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Background color.',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: circleShape,
                      height: circleShape,
                      decoration: BoxDecoration(
                        // Custom color here
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        // borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.circle,
                      ),
                    ),
                    ...ColorPicker.backgroundColors
                        .map(
                          (color) => GestureDetector(
                            onTap: () {
                              if (color == selectedColor) {
                                return;
                              } else {
                                setState(() {
                                  selectedColor = color;
                                });
                                notes.changeCurrentColor(
                                    widget.id, selectedColor);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              width: circleShape,
                              height: circleShape,
                              decoration: BoxDecoration(
                                color: color,
                                // borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.circle,
                                border: color == selectedColor
                                    ? Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patterns',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Overlay on top of the background color.',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...ColorPicker.patterns
                        .map(
                          (pattern) => Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: circleShape,
                            height: circleShape,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: pattern,
                                fit: BoxFit.cover,
                              ),
                              color: Colors.black,
                              // borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Font Color',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Default is white, Try something different.',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(.5),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: circleShape,
                      height: circleShape,
                      decoration: BoxDecoration(
                        // Custom color here
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        // borderRadius: BorderRadius.circular(10),
                        shape: BoxShape.circle,
                      ),
                    ),
                    ...ColorPicker.fontColors
                        .map(
                          (color) => Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: circleShape,
                            height: circleShape,
                            decoration: BoxDecoration(
                              color: color,
                              // borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
