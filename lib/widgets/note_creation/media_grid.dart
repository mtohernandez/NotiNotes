import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../items/icon_button_x_item.dart';

import '../../providers/notes.dart';
import '../../providers/user_data.dart';

class MediaGrid extends StatefulWidget {
  final Function pickImage;
  final String id;
  final String title;
  final String subtitle;
  final bool isForUser;
  const MediaGrid(this.pickImage, this.id, this.isForUser,
      {required this.title, required this.subtitle, super.key});

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text('An error occured',
              style: Theme.of(context).textTheme.displayMedium),
          content: Text('Something went wrong',
              style: Theme.of(context).textTheme.bodyLarge),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  Future<void> _showImagePicker(BuildContext context, Notes notes,
      ImageSource source, bool isForUser, UserData user) async {
    try {
      final imagePicked = await widget.pickImage(source, isForUser ? 40 : 80);
      isForUser
          ? user.updateProfilePicture(imagePicked)
          : notes.addImageToNote(widget.id, imagePicked);
    } on Exception {
      _showErrorDialog(context); // This probably wont happen
    }
  }

  Widget _buildImageSelection(
    BuildContext context,
    String title,
    Notes notes,
    ImageSource source,
    SvgPicture icon,
    bool isForUser,
    UserData user,
    bool isDeletion,
  ) {
    return GestureDetector(
      onTap: () {
        isDeletion && isForUser
            ? user.removeProfilePicture()
            : _showImagePicker(context, notes, source, isForUser, user);
      },
      child: Container(
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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);
    final notes = Provider.of<Notes>(context, listen: false);
    final exitCreator = Navigator.of(context).pop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            IconButtonXItem(exitCreator),
          ],
        ),
        Text(
          widget.subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                // Using copyWith to change the opacity of the text
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(.5),
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.count(
          crossAxisCount: widget.isForUser ? 3 : 2,
          crossAxisSpacing: 5,
          childAspectRatio: 50 / 30,
          shrinkWrap: true,
          children: [
            _buildImageSelection(
              context,
              'From gallery',
              notes,
              ImageSource.gallery,
              SvgPicture.asset('lib/assets/icons/gallery.svg'),
              widget.isForUser,
              user,
              false,
            ),
            _buildImageSelection(
              context,
              'Take it yourself',
              notes,
              ImageSource.camera,
              SvgPicture.asset('lib/assets/icons/camera.svg'),
              widget.isForUser,
              user,
              false,
            ),
            if (widget.isForUser)
              _buildImageSelection(
                context,
                'Remove image',
                notes,
                ImageSource.gallery,
                SvgPicture.asset('lib/assets/icons/removeUser.svg'),
                true,
                user,
                true,
              ),
          ],
        ),
      ],
    );
  }
}
