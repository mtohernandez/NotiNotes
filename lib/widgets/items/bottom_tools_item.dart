import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';

class BottomToolsItem extends StatelessWidget {
  final Function pickImage;
  final Function addTags;
  Color colorBeforeChange;
  final String id;
  BottomToolsItem({
    required this.pickImage,
    required this.addTags,
    required this.id,
    required this.colorBeforeChange,
    super.key,
  });

  Future<bool> _showColorPicker(BuildContext context) async {
    return ColorPicker(
      onColorChanged: (newColor) {
        colorBeforeChange = newColor;
      },
      actionButtons: const ColorPickerActionButtons(
        dialogOkButtonLabel: 'SET',
      ),
      color: Provider.of<Notes>(context, listen: false)
          .findById(id)
          .colorBackground,
      width: 40,
      height: 40,
      borderRadius: 20,
      spacing: 5,
      wheelDiameter: MediaQuery.of(context).size.width * .5,
      heading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Select a color',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
      enableShadesSelection: false,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.accent: false,
        ColorPickerType.primary: true,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      constraints: BoxConstraints.tightFor(
          width: MediaQuery.of(context).size.width * .5,
          height: MediaQuery.of(context).size.height * .45),
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Consumer<Notes>(
          builder: (ctx, notes, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/task.svg',
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/notification.svg',
                  color: Theme.of(context).primaryColor.withOpacity(.2), // Because of the current color which is white
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/hashtag.svg',
                  color: notes.findById(id).tags.isNotEmpty
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(.5),
                ),
                onPressed: () {
                  addTags(context);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/image.svg',
                  color: notes.findById(id).imageFile != null
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(.5),
                ),
                onPressed: () {
                  pickImage(context);
                },
              ),
              MaterialButton(
                onPressed: () async {
                  //? The colorBeforeChange does change the color value inside the ColorPicker
                  //? If the _showColorPicker is not canceled (false), the colorBeforeChange will not change
                  if (await _showColorPicker(context)) {
                    notes.changeCurrentColor(id, colorBeforeChange);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 24,
                color: notes.findById(id).colorBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
