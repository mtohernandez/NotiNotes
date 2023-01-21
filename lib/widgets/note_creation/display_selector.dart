import 'package:flutter/material.dart';
import 'package:noti_notes_app/helpers/display_helper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/notes.dart';

import '../../widgets/items/icon_button_x_item.dart';
import '../../models/note.dart';

class DisplaySelector extends StatelessWidget {
  final String id;
  final DisplayMode displayMode;
  const DisplaySelector(this.id, this.displayMode, {super.key});

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);

    exitCreator() {
      Navigator.of(context).pop();
    }

    return Column(
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
        const SizedBox(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...DisplayModes.displayModes
                  .map((e) => GestureDetector(
                        onTap: () {
                          notes.changeCurrentDisplay(id, e['display']);
                        },
                        child: Opacity(
                          opacity:
                              notes.findById(id).displayMode == e['display']
                                  ? 1
                                  : 0.5,
                          child: SvgPicture.asset(
                            e['asset'],
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            DisplayModes.getDisplayMode(
                notes.findById(id).displayMode)['display']!,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Center(
          child: Text(
            DisplayModes.getDisplayMode(
                notes.findById(id).displayMode)['description']!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(0.5),
                ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
