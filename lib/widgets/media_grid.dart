import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/notes.dart';

class MediaGrid extends StatefulWidget {
  final Function pickImage;
  final String id;
  const MediaGrid(this.pickImage, this.id, {super.key});

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('An error occured'),
          content: Text('Something went wrong'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context, listen: false);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                try {
                  final imagePicked =
                      await widget.pickImage(ImageSource.gallery, widget.id);
                  notes.addImageToNote(widget.id, imagePicked);
                } catch (error) {
                  _showErrorDialog(context);
                }
              },
              child: Text(
                'Select from gallery',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final imagePicked =
                      await widget.pickImage(ImageSource.camera, widget.id);
                  notes.addImageToNote(widget.id, imagePicked);
                } on Exception catch (error) {
                  _showErrorDialog(context);
                }
              },
              child: Text(
                'Take Image',
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.5),
                  fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
