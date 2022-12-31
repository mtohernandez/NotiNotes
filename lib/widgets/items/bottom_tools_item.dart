import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';

class BottomToolsItem extends StatelessWidget {
  final Function pickImage;
  final Function addTags;
  final String id;
  final TabController tabController;
  BottomToolsItem({
    required this.pickImage,
    required this.addTags,
    required this.id,
    required this.tabController,
    super.key,
  });

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Color picker'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Consumer<Notes>(
          builder: (ctx, notes, _) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/brush.svg',
                  color: Theme.of(context).primaryColor.withOpacity(.2),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/task.svg',
                  color: notes.findById(id).todoList.isNotEmpty
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(.5),
                ),
                onPressed: () {
                  tabController.animateTo(1);
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icons/notification.svg',
                  color: Theme.of(context).primaryColor.withOpacity(
                      .2), // Because of the current color which is white
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
                onPressed: () {
                  //? The colorBeforeChange does change the color value inside the ColorPicker
                  //? If the _showColorPicker is not canceled (false), the colorBeforeChange will not change
                  // if (await _showColorPicker(context)) {
                  //   notes.changeCurrentColor(id, colorBeforeChange);
                  // }
                  _showColorPicker(context);
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
