import 'package:event_hub/model/event_data.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  String _selectedCategory = "All";
  String _searchQuery = "";

  bool _isSortedByPrice = false;
  bool _isSortedByDate = false;
  bool _isSortedBySmartChoice = false;

  String get selectedCategory => _selectedCategory;

  List<EventModel> get filteredEvents {
    final eventsByCategory = EventRepository.allEvents.where((event) {
      return _selectedCategory == "All" || event.category == _selectedCategory;
    }).toList();

    List<EventModel> result;

    if (_searchQuery.isEmpty) {
      result = List.from(eventsByCategory);
    } else {
      final startMatches = eventsByCategory.where((event) {
        return event.title.toLowerCase().startsWith(_searchQuery.toLowerCase());
      }).toList();

      final containsMatches = eventsByCategory.where((event) {
        return event.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
            !event.title.toLowerCase().startsWith(_searchQuery.toLowerCase());
      }).toList();

      result = [...startMatches, ...containsMatches];
    }

    if (_isSortedBySmartChoice) {
      result.sort((a, b) {
        int dateComparison = a.datetime.compareTo(b.datetime);

        if (dateComparison == 0) {
          return a.price.compareTo(b.price);
        }
        return dateComparison;
      });
    } else if (_isSortedByPrice) {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (_isSortedByDate) {
      result.sort((a, b) => a.datetime.compareTo(b.datetime));
    }

    return result;
  }

  void sortBySmartChoice() {
    _isSortedBySmartChoice = true;
    _isSortedByPrice = false;
    _isSortedByDate = false;
    notifyListeners();
  }

  void sortByPriceLowToHigh() {
    _isSortedByPrice = true;
    _isSortedByDate = false;
    _isSortedBySmartChoice = false;
    notifyListeners();
  }

  void sortByDate() {
    _isSortedByDate = true;
    _isSortedByPrice = false;
    _isSortedBySmartChoice = false;
    notifyListeners();
  }

  void resetSort() {
    _isSortedByPrice = false;
    _isSortedByDate = false;
    _isSortedBySmartChoice = false;
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
