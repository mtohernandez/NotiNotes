import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaGrid extends StatefulWidget {
  final Function pickImage;
  const MediaGrid(this.pickImage, {super.key});

  @override
  State<MediaGrid> createState() => _MediaGridState();
}

class _MediaGridState extends State<MediaGrid> {
  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                widget.pickImage(ImageSource.gallery);
              },
              child: Text(
                'Select from gallery',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            TextButton(
              onPressed: () {
                widget.pickImage(ImageSource.camera);
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
