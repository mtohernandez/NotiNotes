import 'package:flutter/material.dart';

enum SearchType {
  notSearching,
  searchingByTitle,
  searchingByTag,
}

/// Top-bar filter chips on the home screen.
enum NoteFilter { all, reminders, checklists, images }

class Search with ChangeNotifier {
  SearchType _isSearching = SearchType.notSearching;
  String _searchQuery = '';
  final Set<String> _searchTags = {};
  NoteFilter _filter = NoteFilter.all;

  SearchType get isSearching => _isSearching;
  String get searchQuery => _searchQuery;
  Set<String> get searchTags => _searchTags;
  NoteFilter get filter => _filter;

  void setFilter(NoteFilter f) {
    _filter = f;
    notifyListeners();
  }

  void activateSearchByTitle() {
    _isSearching = SearchType.searchingByTitle;
    notifyListeners();
  }

  void activateSearchByTag() {
    _isSearching = SearchType.searchingByTag;
    notifyListeners();
  }

  void deactivateSearch() {
    _isSearching = SearchType.notSearching;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addSearchTagsQuery(String tag) {
    _searchTags.add(tag);
    notifyListeners();
  }

  void removeSearchTagsQuery(String tag) {
    _searchTags.remove(tag);
    notifyListeners();
  }

  void checkifSearchTagsQueryIsEmpty() {
    if (_searchTags.isEmpty) {
      deactivateSearch();
    } else {
      _isSearching = SearchType.searchingByTag;
    }
    notifyListeners();
  }
}
