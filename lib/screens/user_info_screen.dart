import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/helpers/photo_picker.dart';
import 'package:provider/provider.dart';

import '../widgets/items/tag_item.dart';
import '../widgets/media_grid.dart';

import '../providers/notes.dart';
import '../providers/user_data.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/user-info';
  const UserInfoScreen({super.key});

  Set<String> importMostUsedTags(Notes notes) {
    return notes.notes.fold(
      <String>{},
      (previousValue, note) => previousValue..addAll(note.tags),
    );
  }

  Widget _buildMostUsedTags(BuildContext context) {
    // Get a set<string> of the most used tags
    final mostUsedTags =
        Provider.of<Notes>(context, listen: false).getMostUsedTags();

    return mostUsedTags.isNotEmpty
        ? SizedBox(
            height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => TagItem(
                null,
                0,
                tag: mostUsedTags.elementAt(index),
                isForSearch: false,
                isForCreation: false,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
              itemCount: mostUsedTags.length,
            ),
          )
        : Text(
            'No tags yet.',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      Theme.of(context).textTheme.bodyText1!.color!.withOpacity(
                            .5,
                          ),
                  fontStyle: FontStyle.italic,
                ),
          );
  }

  Widget _buildNoteOptions(
      BuildContext context, String title, String subtitle, SvgPicture icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor.withOpacity(.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .headline4!
                      .color!
                      .withOpacity(.5),
                ),
          ),
        ],
      ),
    );
  }

  void openMediaPicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bctx) {
        return Wrap(
          children: const [
            MediaGrid(
              PhotoPicker.pickImage,
              '',
              true,
              title: 'Choose profile picture',
              subtitle: 'You can remove it too.',
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    final notes = Provider.of<Notes>(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Your profile',
              style: Theme.of(context).textTheme.headline1),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => openMediaPicker(context),
                    child: Container(
                      // TODO: Make this values responsive
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: user.curentUserData.profilePicture != null
                            ? DecorationImage(
                                image: FileImage(
                                    user.curentUserData.profilePicture!),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                image: AssetImage(
                                  'lib/assets/images/noProfilePicture.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Theme.of(context).textTheme.headline1!.fontSize,
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 15,
                          initialValue: user.curentUserData.name,
                          style: Theme.of(context).textTheme.headline1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'Your name',
                            hintStyle: Theme.of(context).textTheme.headline1,
                            counter: const SizedBox.shrink(),
                          ),
                          onChanged: (name) {
                            user.updateName(name);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   'Favorite Color: ${user.curentUserData.favoriteColor}',
                      //   style: Theme.of(context).textTheme.headline3,
                      // ),
                      Text(
                        '${notes.notesCount} notes on this device.',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Tags you use the most',
                  style: Theme.of(context).textTheme.headline1),
              const SizedBox(
                height: 10,
              ),
              Consumer<Notes>(
                builder: (context, notesData, child) {
                  return _buildMostUsedTags(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  children: [
                    _buildNoteOptions(
                      context,
                      'NoteDrop',
                      'The people you sent note to will see your profile.',
                      SvgPicture.asset(
                        'lib/assets/icons/notedrop.svg',
                        height: 30,
                      ),
                    ),
                    _buildNoteOptions(
                      context,
                      'Audio Notes',
                      'Record your voice and save it as a note.',
                      SvgPicture.asset(
                        'lib/assets/icons/mic.svg',
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
