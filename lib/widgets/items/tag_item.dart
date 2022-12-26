import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/search.dart';

class TagItem extends StatefulWidget {
  final String tag;
  final bool isForSearch;
  const TagItem({
    super.key,
    required this.tag,
    required this.isForSearch,
  });

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final isSearching = Provider.of<Search>(context);

    return GestureDetector(
      onTap: () {
        if (widget.isForSearch) {
          setState(() {
            isSelected = !isSelected;
          });
          isSelected
              ? isSearching.addSearchTagsQuery(widget.tag)
              : isSearching.removeSearchTagsQuery(widget.tag);

          isSearching.checkifSearchTagsQueryIsEmpty();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : widget.isForSearch
                  ? Colors.grey
                  : Colors.transparent,
          border: widget.isForSearch
              ? Border.all(width: 0)
              : Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                  width: 1,
                ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.tag,
          style: isSelected
              ? Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).backgroundColor,
                  )
              : widget.isForSearch
                  ? Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).backgroundColor,
                      )
                  : Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
