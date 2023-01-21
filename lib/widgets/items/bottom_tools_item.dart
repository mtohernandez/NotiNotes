import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/note.dart';
import '../../providers/notes.dart';
import '../../widgets/note_creation/color_picker_creator.dart';
import '../../helpers/color_picker.dart';

class BottomToolsItem extends StatelessWidget {
  final Function pickImage;
  final Function addTags;
  final Function displayMode;
  final String id;
  Color colorBeforeChange; //! TO FIX
  final TabController tabController;
  BottomToolsItem({
    required this.pickImage,
    required this.addTags,
    required this.displayMode,
    required this.colorBeforeChange, //! TO FIX
    required this.id,
    required this.tabController,
    super.key,
  });

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        backgroundColor: Theme.of(context).backgroundColor,
        content: ColorPickerCreator(id),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
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
                  color: notes.findById(id).displayMode != DisplayMode.normal
                      ? Theme.of(context).primaryColor.withOpacity(.5)
                      : Theme.of(context).primaryColor.withOpacity(.2),
                ),
                onPressed: () {
                  displayMode(context);
                },
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
              GestureDetector(
                onTap: () {
                  _showColorPicker(context);
                },
                child: Container(
                  constraints: const BoxConstraints(
                      maxHeight: 24, minWidth: 90), //! TO FIX
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: notes.findById(id).colorBackground,
                    image: notes.findById(id).patternImage != null
                        ? DecorationImage(
                            colorFilter: ColorFilter.mode(
                              ColorPicker.darken(
                                  notes.findById(id).colorBackground, 0.1),
                              BlendMode.srcATop,
                            ),
                            image: AssetImage(notes.findById(id).patternImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
