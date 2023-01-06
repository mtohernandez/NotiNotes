import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../screens/information_screen.dart';
import '../../screens/user_info_screen.dart';
import '../../widgets/items/tag_item.dart';

import '../../providers/notes.dart';
import '../../providers/user_data.dart';

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

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    final user = Provider.of<UserData>(context, listen: false);

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
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      user.greetingToUser,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Consumer<UserData>(
                      builder: (context, user, child) =>
                          user.curentUserData.profilePicture != null
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(UserInfoScreen.routeName);
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: FileImage(
                                        user.curentUserData.profilePicture!),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(UserInfoScreen.routeName);
                                  },
                                  child: SvgPicture.asset(
                                    'lib/assets/icons/user.svg',
                                    color: Colors.white,
                                  ),
                                ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(InformationScreen.routeName);
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
                    null,
                    0,
                    tag: allTags.elementAt(index),
                    isForSearch: true,
                    isForCreation: false,
                    backgroundColor: Theme.of(context).backgroundColor, // Does not matter
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
