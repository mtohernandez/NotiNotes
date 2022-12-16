import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/screens/notes_creation_screen.dart';

class BottomNavigationCustomItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff292929),
                  hintText: 'Search Notes',
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.5),
                    fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                ),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(width: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.5),
                  radius:
                      Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(NotesCreationScreen.routeName);
                  },
                  icon: SvgPicture.asset(
                    'lib/assets/icons/plus.svg',
                    color: Theme.of(context).backgroundColor,
                    height:
                        Theme.of(context).textTheme.bodyText1!.fontSize! * 2.7,
                    width:
                        Theme.of(context).textTheme.bodyText1!.fontSize! * 2.7,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
