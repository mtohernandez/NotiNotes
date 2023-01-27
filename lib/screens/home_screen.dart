import 'package:flutter/material.dart';
import 'package:noti_notes_app/widgets/items/appbar_content_item.dart';
import 'package:noti_notes_app/widgets/items/issearch_box_item.dart';
import 'package:noti_notes_app/widgets/navigation/bottom_navigation_custom_item.dart';
import 'package:provider/provider.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'dart:math';

import 'package:noti_notes_app/widgets/items/note_item.dart';
import 'package:noti_notes_app/providers/notes.dart';
import 'package:noti_notes_app/providers/search.dart';
import 'package:noti_notes_app/widgets/items/apbar_title_item.dart';
import 'package:noti_notes_app/widgets/items/icon_button_x_item.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});

  Widget _buildCenterMessage(BuildContext context, String message) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * .4),
      height: MediaQuery.of(context).size.height * 0.6, // This may not work
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .color!
                    .withOpacity(0.5),
              ),
        ),
      ),
    );
  }

  Widget _searchingMessage(BuildContext context, Search isSearching) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Searching "${isSearching.searchQuery}"',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        IconButtonXItem(isSearching.deactivateSearch),
      ],
    );
  }

  Widget _buildPersistenHeader(BuildContext context, Widget child) {
    final sliverHeight = Theme.of(context).textTheme.bodyText1!.fontSize! * 2.5;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: sliverHeight,
        maxHeight: sliverHeight,
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: child,
        ),
      ),
    );
  }

  Widget _buildSpacer(BuildContext context, double? height) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    final isSearching = Provider.of<Search>(context);
    final appBarSize = Theme.of(context).textTheme.bodyText1!.fontSize! * 2;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // notes.editMode = false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 10,
            right: 10,
          ),
          child: CustomScrollView(
            slivers: [
              _buildSpacer(context, MediaQuery.of(context).padding.top),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const TitleItem(),
                ),
              ),
              SliverAppBar(
                backgroundColor: Theme.of(context).backgroundColor,
                pinned: true,
                floating: false,
                snap: false,
                elevation: 0,
                expandedHeight: appBarSize,
                toolbarHeight: appBarSize,
                flexibleSpace: const FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  titlePadding: EdgeInsets.symmetric(vertical: 10),
                  title: AppBarContentItem(),
                ),
              ),
              if (notes.editMode &&
                  isSearching.isSearching == SearchType.notSearching)
                _buildPersistenHeader(context, const IsSearchBoxItem()),
              if (isSearching.isSearching == SearchType.searchingByTitle)
                _buildPersistenHeader(
                  context,
                  _searchingMessage(
                    context,
                    isSearching,
                  ),
                ),
              _buildSpacer(context, null),
              SliverToBoxAdapter(
                child: isSearching.isSearching == SearchType.notSearching &&
                        notes.notes.isEmpty
                    ? _buildCenterMessage(
                        context, 'No notes yet, press + to add one!')
                    : notes.filterByTitle(isSearching.searchQuery).isEmpty &&
                            isSearching.isSearching ==
                                SearchType.searchingByTitle
                        ? _buildCenterMessage(context, 'No notes found...')
                        : MasonryGrid(
                            column: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            children: [
                              if (isSearching.isSearching ==
                                  SearchType.notSearching)
                                ...notes.notes
                                    .map(
                                      (note) => NoteItem(
                                        note.tags,
                                        note.imageFile,
                                        note.patternImage,
                                        note.todoList,
                                        id: note.id,
                                        title: note.title,
                                        content: note.content,
                                        date: note.dateCreated,
                                        colorBackground: note.colorBackground,
                                        fontColor: note.fontColor,
                                        displayMode: note.displayMode,
                                      ),
                                    )
                                    .toList(),
                              if (isSearching.isSearching ==
                                  SearchType.searchingByTitle)
                                ...notes
                                    .filterByTitle(isSearching.searchQuery)
                                    .map(
                                      (note) => NoteItem(
                                        note.tags,
                                        note.imageFile,
                                        note.patternImage,
                                        note.todoList,
                                        id: note.id,
                                        title: note.title,
                                        content: note.content,
                                        date: note.dateCreated,
                                        colorBackground: note.colorBackground,
                                        fontColor: note.fontColor,
                                        displayMode: note.displayMode,
                                      ),
                                    )
                                    .toList(),
                              if (isSearching.isSearching ==
                                  SearchType.searchingByTag)
                                ...notes
                                    .filterByTag(isSearching.searchTags)
                                    .map(
                                      (note) => NoteItem(
                                        note.tags,
                                        note.imageFile,
                                        note.patternImage,
                                        note.todoList,
                                        id: note.id,
                                        title: note.title,
                                        content: note.content,
                                        date: note.dateCreated,
                                        colorBackground: note.colorBackground,
                                        fontColor: note.fontColor,
                                        displayMode: note.displayMode,
                                      ),
                                    )
                                    .toList(),
                            ],
                          ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavigationCustomItem(),
      ),
    );
  }
}

// In order to make the EditMode and SearchBox persisten, we need to use a SliverPersistentHeaderDelegate and created in a separated class

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  // 2
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  // 3
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
