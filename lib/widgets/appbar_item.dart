import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noti_notes_app/screens/login_screen.dart';
import 'package:noti_notes_app/widgets/tag_item.dart';
import 'package:provider/provider.dart';

import '../providers/notes.dart';

class AppBarItemTop extends StatelessWidget implements PreferredSizeWidget {
  final double size;

  const AppBarItemTop(this.size, {super.key});

  Set<String> importTags(Notes notes) {
    // Using fold to return a set of all tags from all notes in the notes provider
    return notes.notes.fold(
      <String>{},
      (previousValue, note) => previousValue..addAll(note.tags),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    Set<String> allTags = importTags(notes);

    return AppBar(
      toolbarHeight: size,
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Good ${greeting()}',
                style: Theme.of(context).textTheme.headline1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(LoginSignupScreen.routeName);
                },
                child: CircleAvatar(
                  radius: Theme.of(context).textTheme.headline1!.fontSize! * .6,
                  backgroundImage: const AssetImage(
                    'lib/assets/images/Image1.jpg',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => TagItem(
                tag: allTags.elementAt(index),
              ),
              itemCount: allTags.length,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size);
}
