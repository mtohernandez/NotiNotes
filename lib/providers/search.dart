import 'package:flutter/material.dart';

enum SearchType {
  notSearching,
  searchingByTitle,
  searchingByTag,
}

class Search with ChangeNotifier{
  SearchType _isSearching = SearchType.notSearching;
  String _searchQuery = '';

  SearchType get isSearching => _isSearching;
  String get searchQuery => _searchQuery;

  void activateSearchByTitle(){
    _isSearching = SearchType.searchingByTitle;
    notifyListeners();
  }

  void activateSearchByTag(){
    _isSearching = SearchType.searchingByTag;
    notifyListeners();
  }

  void deactivateSearch(){
    _isSearching = SearchType.notSearching;
    notifyListeners();
  }

  void setSearchQuery(String query){
    _searchQuery = query;
    notifyListeners();
  }
}