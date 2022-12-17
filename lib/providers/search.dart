import 'package:flutter/material.dart';

class Search with ChangeNotifier{
  bool _isSearching = false;
  String _searchQuery = '';

  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;

  void activateSearch(){
    _isSearching = true;
    notifyListeners();
  }

  void deactivateSearch(){
    _isSearching = false;
    notifyListeners();
  }

  void setSearchQuery(String query){
    _searchQuery = query;
    notifyListeners();
  }
}