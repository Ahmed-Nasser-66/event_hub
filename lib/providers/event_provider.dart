import 'package:flutter/material.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/model/event_data.dart';

class EventProvider extends ChangeNotifier {
  String _selectedCategory = "All";

  String _searchQuery = "";

  String get selectedCategory => _selectedCategory;
  List<EventModel> get filteredEvents {
    final eventsByCategory = EventRepository.allEvents.where((event) {
      return _selectedCategory == "All" || event.category == _selectedCategory;
    }).toList();

    final startMatches = eventsByCategory
        .where(
          (event) =>
              event.title.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    final containsMatches = eventsByCategory
        .where(
          (event) =>
              event.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
              !event.title.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    return [...startMatches, ...containsMatches];
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
