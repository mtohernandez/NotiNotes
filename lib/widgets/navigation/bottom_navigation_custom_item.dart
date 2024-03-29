import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noti_notes_app/screens/note_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../providers/search.dart';

class BottomNavigationCustomItem extends StatefulWidget {
  const BottomNavigationCustomItem({super.key});

  @override
  State<BottomNavigationCustomItem> createState() =>
      _BottomNavigationCustomItemState();
}

class _BottomNavigationCustomItemState
    extends State<BottomNavigationCustomItem> {
  final _searchNode = FocusNode();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _handleNoteCreation() {
    return const Uuid().v1();
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = Provider.of<Search>(context);

    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff292929),
                  hintText: 'Search Notes',
                  hintStyle: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(.5),
                    fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                ),
                controller: _searchController,
                style: Theme.of(context).textTheme.bodyText1,
                onChanged: (value) {
                  isSearching.activateSearchByTitle();
                  isSearching.setSearchQuery(value);
                  if (value.isEmpty) isSearching.deactivateSearch();
                },
                onSubmitted: (value) => _searchController.clear(),
              ),
            ),
            const SizedBox(width: 10),
            if (_searchController.text.isEmpty)
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    NoteViewScreen.routeName,
                    arguments: _handleNoteCreation(),
                  );
                },
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                icon: SvgPicture.asset(
                  'lib/assets/icons/plus.svg',
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.5),
                  height:
                      Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5,
                  width: Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5,
                ),
              ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  //? Placing the set state here avoids the checkmark from not updating and returning back to the plus icon, small bug
                  setState(() {
                    _searchController.clear();
                  });
                  // isSearching.deactivateSearch();
                  FocusScope.of(context).unfocus();
                },
                icon: SvgPicture.asset(
                  'lib/assets/icons/check.svg',
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .color!
                      .withOpacity(.5),
                  height:
                      Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5,
                  width: Theme.of(context).textTheme.bodyText1!.fontSize! * 1.5,
                ),
              )
          ],
        ),
      ),
    );
  }
}
