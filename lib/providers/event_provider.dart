import 'package:flutter/material.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/model/event_data.dart';

class EventProvider extends ChangeNotifier {
  String _selectedCategory = "All";
  
  String _searchQuery = "";

  String get selectedCategory => _selectedCategory;

  List<EventModel> get filteredEvents {
    return EventRepository.allEvents.where((event) {
      final isMatchingCategory = _selectedCategory == "All" || event.category == _selectedCategory;
      final isMatchingSearch = event.title.toLowerCase().contains(_searchQuery.toLowerCase());
      return isMatchingCategory && isMatchingSearch;
    }).toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); 
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}