import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final String tag;
  const TagItem({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
