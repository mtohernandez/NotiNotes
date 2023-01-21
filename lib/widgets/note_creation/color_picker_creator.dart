import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart' as flex;

import '../../widgets/items/icon_button_x_item.dart';
import '../../helpers/color_picker.dart';
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
  var isWheelActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    selectedColor = Provider.of<Notes>(context).findColor(widget.id);
    selectedPattern = Provider.of<Notes>(context).findPatternImage(widget.id);
    selectedFontColor = Provider.of<Notes>(context).findFontColor(widget.id);
  }

  void deactivateWheel() {
    setState(() {
      isWheelActive = false;
    });
  }

  Widget _buildPicker() {
    return Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                deactivateWheel();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Card(
              color: Theme.of(context).backgroundColor,
              elevation: 0,
              child: flex.ColorPicker(
                pickersEnabled: const <flex.ColorPickerType, bool>{
                  flex.ColorPickerType.accent: false,
                  flex.ColorPickerType.primary: false,
                  flex.ColorPickerType.wheel: true,
                },
                // Use the screenPickerColor as start color.
                color: Provider.of<Notes>(context, listen: false)
                    .findColor(widget.id),
                // Update the screenPickerColor using the callback.
                onColorChanged: (Color color) => setState(() =>
                    Provider.of<Notes>(context, listen: false)
                        .changeCurrentColor(widget.id, color)),
                width: 44,
                height: 44,
                borderRadius: 22,
              ),
            ),
          ),
        ),
      ],
    );
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
          isWheelActive
              ? _buildPicker()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Default palette',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          'Background color.',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isWheelActive = true;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  width: circleShape,
                                  height: circleShape,
                                  decoration: BoxDecoration(
                                    // Custom color here
                                    color: ColorPicker.backgroundColors
                                            .contains(notes
                                                .findById(widget.id)
                                                .colorBackground)
                                        ? Colors.transparent
                                        : selectedColor,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                              GestureDetector(
                                onTap: () {
                                  notes.removeCurrentPattern(widget.id);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  width: circleShape,
                                  height: circleShape,
                                  decoration: BoxDecoration(
                                    // Custom color here
                                    color: notes
                                        .findById(widget.id)
                                        .colorBackground,
                                    border: !ColorPicker.patterns
                                            .contains(selectedPattern)
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                        : null,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
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
                                            colorFilter: ColorFilter.mode(
                                              notes
                                                  .findById(widget.id)
                                                  .colorBackground,
                                              BlendMode.dstATop,
                                            ),
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
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
