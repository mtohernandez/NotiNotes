import 'package:flutter/material.dart';
import 'package:noti_notes_app/helpers/color_picker.dart';
import 'package:provider/provider.dart';

import '../../widgets/items/icon_button_x_item.dart';

import '../../providers/notes.dart';

class ColorPickerCreator extends StatefulWidget {
  final String id;
  const ColorPickerCreator(this.id, {super.key});

  @override
  State<ColorPickerCreator> createState() => _ColorPickerCreatorState();
}

class _ColorPickerCreatorState extends State<ColorPickerCreator> {
  late Color selectedColor;
  late Color selectedFontColor;
  late String? selectedPattern;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    selectedColor = Provider.of<Notes>(context).findColor(widget.id);
    selectedPattern = Provider.of<Notes>(context).findPatternImage(widget.id);
    selectedFontColor = Provider.of<Notes>(context).findFontColor(widget.id);
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
                          (pattern) => GestureDetector(
                            onTap: () async {
                              if (selectedPattern == pattern) {
                                return;
                              } else {
                                setState(() {
                                  selectedPattern = pattern;
                                }); // Force to update
                                notes.changeCurrentPattern(
                                    widget.id, selectedPattern);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              width: circleShape,
                              height: circleShape,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(pattern),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.black,
                                // borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.circle,
                                border: selectedPattern == pattern
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
                'Font Color',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Default is white, try something different.',
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
                          (color) => GestureDetector(
                            onTap: () {
                              if (color == selectedFontColor) {
                                return;
                              } else {
                                setState(() {
                                  selectedFontColor = color;
                                });
                                notes.changeCurrentFontColor(
                                    widget.id, selectedFontColor);
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
                                border: color == selectedFontColor
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
        ],
      ),
    );
  }
}
