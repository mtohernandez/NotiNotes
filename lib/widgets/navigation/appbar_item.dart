import 'package:flutter/material.dart';
import 'package:noti_notes_app/screens/login_screen.dart';
import 'package:noti_notes_app/widgets/items/tag_item.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../providers/notes.dart';

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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Theme.of(context).backgroundColor,
          ],
        ),
      ),
      child: AppBar(
        toolbarHeight: size,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleSpacing: 15,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Good ${greeting()}',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(LoginSignupScreen.routeName);
                      },
                      child: SvgPicture.asset(
                        'lib/assets/icons/user.svg',
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(LoginSignupScreen.routeName);
                      },
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (allTags.isNotEmpty)
              SizedBox(
                height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => TagItem(
                    tag: allTags.elementAt(index),
                    isForSearch: true,
                  ),
                  itemCount: allTags.length,
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size);
}
