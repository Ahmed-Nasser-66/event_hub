import 'package:event_hub/model/event_data.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  String _selectedCategory = "All";
  String _searchQuery = "";

  
  bool _isSortedByPrice = false;

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

    
    List<EventModel> result = [...startMatches, ...containsMatches];

    
    if (_isSortedByPrice) {
      result.sort((a, b) => a.price.compareTo(b.price));
    }

    return result;
  }

  
  void sortByPriceLowToHigh() {
    _isSortedByPrice = true;
    notifyListeners(); 
  }

  
  void resetSort() {
    _isSortedByPrice = false;
    notifyListeners();
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
