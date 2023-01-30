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
  late LinearGradient? selectedGradient;
  late String? selectedPattern;
  var isWheelActive = false;
  var isGradientActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    selectedColor = Provider.of<Notes>(context).findColor(widget.id);
    selectedPattern = Provider.of<Notes>(context).findPatternImage(widget.id);
    selectedFontColor = Provider.of<Notes>(context).findFontColor(widget.id);
    selectedGradient = Provider.of<Notes>(context).findGradient(widget.id);
  }

  void deactivateWheel() {
    setState(() {
      isWheelActive = false;
    });
  }

  void activateGradient() {
    setState(() {
      isGradientActive = true;
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

  Widget _buildTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(.5),
              ),
        ),
      ],
    );
  }

  SingleChildScrollView _buildSinglePalette(
    String id,
    List<dynamic> palette,
    dynamic selected,
    Function changeOnData,
    double circleShape,
    Color colorBackground, [
    LinearGradient? gradientBackground,
  ]) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...palette
              .map(
                (optionSelected) => GestureDetector(
                  onTap: () {
                    if (optionSelected == selected) {
                      return;
                    } else {
                      setState(() {
                        selected = optionSelected;
                      });
                      changeOnData(id, selected);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: circleShape,
                    height: circleShape,
                    decoration: BoxDecoration(
                      color: optionSelected is Color ? optionSelected : null,
                      // borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.circle,
                      border: optionSelected == selected
                          ? Border.all(
                              color: Colors.white,
                              width: 2,
                            )
                          : null,
                      gradient: optionSelected is LinearGradient
                          ? optionSelected
                          : null,
                      image: optionSelected is String
                          ? DecorationImage(
                              image: AssetImage(optionSelected),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                ColorPicker.darken(
                                  colorBackground,
                                  0.2,
                                ),
                                BlendMode.srcATop,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
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
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isWheelActive) _buildPicker(),
              if (!isWheelActive)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isGradientActive
                            ? _buildTitle(
                                'Gradient',
                                'Add more beauty to the note.',
                              )
                            : _buildTitle(
                                'Background Color',
                                'Default is white, try something different.',
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        isGradientActive
                            ? _buildSinglePalette(
                                widget.id,
                                ColorPicker.gradients,
                                selectedGradient,
                                notes.changeCurrentGradient,
                                circleShape,
                                notes.findColor(widget.id),
                                notes.findGradient(widget.id),
                              )
                            : Row(
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
                                  Expanded(
                                    child: _buildSinglePalette(
                                      widget.id,
                                      ColorPicker.backgroundColors,
                                      selectedColor,
                                      notes.changeCurrentColor,
                                      circleShape,
                                      notes.findColor(widget.id),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(
                          'Pattern',
                          'Default is none, try something different.',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  notes.removeCurrentPattern(widget.id);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 5),
                                width: circleShape,
                                height: circleShape,
                                decoration: BoxDecoration(
                                  // Custom color here
                                  color: notes.findColor(widget.id),
                                  border:
                                      notes.findPatternImage(widget.id) == null
                                          ? Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            )
                                          : null,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: _buildSinglePalette(
                                widget.id,
                                ColorPicker.patterns,
                                selectedPattern,
                                notes.changeCurrentPattern,
                                circleShape,
                                notes.findColor(widget.id),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(
                          'Font Color',
                          'Default is white, try something different.',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildSinglePalette(
                          widget.id,
                          ColorPicker.fontColors,
                          selectedFontColor,
                          notes.changeCurrentFontColor,
                          circleShape,
                          notes.findColor(widget.id),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isGradientActive = true;
                        });
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                      ),
                      child: Text(
                        'Switch to gradient.',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color!
                                  .withOpacity(.5),
                            ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
