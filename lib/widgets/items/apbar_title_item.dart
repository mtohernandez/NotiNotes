import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/providers/user_data.dart';
import 'package:noti_notes_app/screens/user_info_screen.dart';
import 'package:noti_notes_app/screens/information_screen.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);
    
    return Row(
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
                            backgroundImage:
                                FileImage(user.curentUserData.profilePicture!),
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
                Navigator.of(context).pushNamed(InformationScreen.routeName);
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
    );
  }
}
