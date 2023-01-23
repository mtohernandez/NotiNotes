import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../providers/search.dart';

class TagItem extends StatefulWidget {
  final String tag;
  final bool isForSearch;
  final bool isForCreation;
  final Function? onDelete;
  final int index;
  final Color backgroundColor;
  const TagItem(this.onDelete, this.index,
      {super.key,
      required this.tag,
      required this.isForSearch,
      required this.isForCreation,
      required this.backgroundColor});

  @override
  State<TagItem> createState() => _TagItemState();
}

class _TagItemState extends State<TagItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final isSearching = Provider.of<Search>(context);
    const borderColor = Color.fromARGB(255, 46, 46, 46);

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
        child: Chip(
          // padding: const EdgeInsets.symmetric(horizontal: 2),
          backgroundColor: isSelected
              ? Theme.of(context).primaryColor
              : widget.isForSearch
                  ? borderColor
                  : widget.backgroundColor,
          shape: StadiumBorder(
            side: BorderSide(
              color: widget.isForSearch
                  ? !isSelected
                      ? borderColor
                      : Colors.white
                  : Colors.white,
              width: 1.0,
            ),
          ),
          label: Text(
            widget.tag,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight:
                      widget.isForSearch ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Colors.black
                      : widget.isForSearch
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyText1!.color,
                ),
          ),
          deleteIcon: widget.isForCreation
              ? Transform.rotate(
                  angle: 45 * math.pi / 180,
                  child: SvgPicture.asset(
                    'lib/assets/icons/plus.svg',
                    height: Theme.of(context).textTheme.bodyText1!.fontSize,
                  ),
                )
              : null,
          onDeleted: widget.isForCreation
              ? () => widget.onDelete!(widget.index)
              : null,
        ),
      ),
    );
  }
}
