import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../items/tag_item.dart';

class TagCreator extends StatelessWidget {
  final Function addTag;
  final Function removeTag;
  final Set<String> allTags;
  TagCreator(this.removeTag, this.addTag, {required this.allTags, super.key});

  final _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tagsSize = Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5;

    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(.5),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              height: Theme.of(context).textTheme.bodyText1!.fontSize! * 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onDoubleTap: () {
                    removeTag(index);
                  },
                  child: TagItem(
                    tag: allTags.elementAt(index),
                    isForSearch: false,
                  ),
                ),
                itemCount: allTags.length,
              ),
            ),
          ),
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: EdgeInsets.zero,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                  title: Text(
                    'Add a tag',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  content: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Tag',
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                // Using copyWith to change the opacity of the text
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color!
                                    .withOpacity(.5),
                              ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _tagController,
                    onSubmitted: (value) {
                      addTag(_tagController);
                    },
                  ),
                  actions: [
                    TextButton(
                      style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        addTag(_tagController);
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: SvgPicture.asset(
              'lib/assets/icons/plus.svg',
              color: Theme.of(context).primaryColor.withOpacity(.5),
              height: tagsSize,
              width: tagsSize,
            ),
          ),
        ],
      ),
    );
  }
}
