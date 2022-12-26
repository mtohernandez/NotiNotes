import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/photo_picker.dart';
import '../providers/notes.dart';
import '../providers/user.dart';

class MediaGrid extends StatefulWidget {
  final Function pickImage;
  final String id;
  final bool isForUser;
  const MediaGrid(this.pickImage, this.id, this.isForUser, {super.key});

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text('An error occured',
              style: Theme.of(context).textTheme.headline2),
          content: Text('Something went wrong',
              style: Theme.of(context).textTheme.bodyText1),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'))
          ],
        );
      },
    );
  }

  Future<void> _showImagePicker(BuildContext context, Notes notes,
      ImageSource source, bool isForUser, UserData user) async {
    try {
      final imagePicked = await widget.pickImage(source);
      isForUser
          ? user.updateProfilePicture(imagePicked)
          : notes.addImageToNote(widget.id, imagePicked);
    } on Exception catch (error) {
      _showErrorDialog(context);
    }
  }

  Widget _buildImageSelection(BuildContext context, String title, Notes notes, ImageSource source, SvgPicture icon,
      bool isForUser, UserData user) {
    return GestureDetector(
      onTap: (){
        _showImagePicker(context, notes, source, isForUser, user);},
      child: Container(
        color: Colors.red,
        child: Column(
          children: [
            icon,
            Text(title),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context, listen: false);
    final notes = Provider.of<Notes>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
