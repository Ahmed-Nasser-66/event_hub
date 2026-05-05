import 'package:dio/dio.dart';
import 'package:event_hub/core/api/events_service.dart';
import 'package:event_hub/model/event_details_model.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CategoryItem {
  final int id;
  final String name;
  final String slug;

  CategoryItem({required this.id, required this.name, required this.slug});
}

class EventProvider extends ChangeNotifier {
  int? _selectedCategoryId;
  String _searchQuery = "";

  bool _isSortedByPrice = false;
  bool _isSortedByDate = false;
  bool _isSortedBySmartChoice = false;

  double? _userLat;
  double? _userLng;

  bool _isLoading = false;
  String? _errorMessage;
  EventsState _state = EventsState.initial;

  List<EventModel> _allEvents = [];

  final List<CategoryItem> _categories = [
    CategoryItem(id: 1, name: 'Art', slug: 'art'),
    CategoryItem(id: 2, name: 'Tech', slug: 'tech'),
    CategoryItem(id: 3, name: 'Gaming', slug: 'gaming'),
    CategoryItem(id: 4, name: 'Business', slug: 'business'),
    CategoryItem(id: 5, name: 'Fashion', slug: 'fashion'),
    CategoryItem(id: 7, name: 'Education', slug: 'education'),
    CategoryItem(id: 8, name: 'Sport', slug: 'sport'),
  ];

  final Dio _dio = Dio(BaseOptions(
    headers: {"Content-Type": "application/json"},
  ));

  int? get selectedCategoryId => _selectedCategoryId;
  List<CategoryItem> get categories => _categories;

  bool get isLoading => _isLoading;
  bool get hasError => _state == EventsState.error;
  String? get errorMessage => _errorMessage;
  EventsState get state => _state;

  // ================== CATEGORY NAME ==================
  String categoryName(int? id) {
    switch (id) {
      case 1:
        return 'Art';
      case 2:
        return 'Tech';
      case 3:
        return 'Gaming';
      case 4:
        return 'Business';
      case 5:
        return 'Fashion';
      case 7:
        return 'Education';
      case 8:
        return 'Sport';
      default:
        return 'Other';
    }
  }

  // ================== FILTER ==================
  List<EventModel> get filteredEvents {
    final eventsByCategory = _allEvents.where((event) {
      return _selectedCategoryId == null ||
          event.categoryId == _selectedCategoryId;
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
        int dateCompare =
            (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now());
        if (dateCompare == 0) {
          return (a.price ?? 0).compareTo(b.price ?? 0);
        }
        return dateCompare;
      });
    } else if (_isSortedByPrice) {
      result.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
    } else if (_isSortedByDate) {
      result.sort((a, b) =>
          (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
    }

    return result;
  }

  // ================== 🔥 NEW ==================
  List<EventModel> get filteredUpcomingEvents {
    final now = DateTime.now();

    return filteredEvents.where((event) {
      if (event.date == null) return false;
      return event.date!.isAfter(now);
    }).toList();
  }

  List<EventModel> get filteredNearbyEvents {
    if (_userLat == null || _userLng == null) {
      return [];
    }

    return filteredEvents.where((event) {
      return event.distance != null;
    }).toList()
      ..sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
  }

  // ================== ACTIONS ==================

  Future<void> selectCategory(CategoryItem category) async {
    if (_selectedCategoryId == category.id) {
      _selectedCategoryId = null;
      await refreshEvents();
    } else {
      _selectedCategoryId = category.id;
      await fetchEventsByCategory(category.slug);
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setUserLocation(double lat, double lng) {
    _userLat = lat;
    _userLng = lng;

    for (var event in _allEvents) {
      event.distance = Geolocator.distanceBetween(
        lat,
        lng,
        event.latitude ?? 0,
        event.longitude ?? 0,
      );
    }

    notifyListeners();
  }

  // ================== SORT FUNCTIONS ==================

  void sortBySmartChoice() {
    _isSortedBySmartChoice = true;
    _isSortedByDate = false;
    _isSortedByPrice = false;
    notifyListeners();
  }

  void sortByDate() {
    _isSortedByDate = true;
    _isSortedBySmartChoice = false;
    _isSortedByPrice = false;
    notifyListeners();
  }

  void sortByPriceLowToHigh() {
    _isSortedByPrice = true;
    _isSortedBySmartChoice = false;
    _isSortedByDate = false;
    notifyListeners();
  }

  void resetSort() {
    _isSortedByPrice = false;
    _isSortedByDate = false;
    _isSortedBySmartChoice = false;
    notifyListeners();
  }

  // ================== CATEGORY API ==================

  Future<void> fetchEventsByCategory(String slug) async {
    _isLoading = true;
    notifyListeners();

    try {
      final eventsService = EventsService(_dio);
      final response = await eventsService.getEventsByCategory(slug);

      if (response.data['success'] == true) {
        final List eventsJson = response.data['message']['data'] ?? [];
        _allEvents = eventsJson.map((e) => EventModel.fromJson(e)).toList();
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint("❌ Error: $e");
      notifyListeners();
    }
  }

  // ================== DETAILS ==================

  Future<EventDetailsModel?> fetchEventDetails(int eventId) async {
    try {
      final eventsService = EventsService(_dio);
      final details = await eventsService.getEventDetails(eventId);
      return details;
    } catch (e) {
      debugPrint("❌ Error fetching event details: $e");
      return null;
    }
  }

  // ================== ALL EVENTS ==================

  Future<void> refreshEvents() async {
    _isLoading = true;
    _state = EventsState.loading;
    notifyListeners();

    try {
      final eventsService = EventsService(_dio);
      final response = await eventsService.getAllEvents();

      if (response.data['success'] == true) {
        final List eventsJson = response.data['message']['data'] ?? [];
        _allEvents = eventsJson.map((e) => EventModel.fromJson(e)).toList();

        _state = EventsState.loaded;
        _errorMessage = null;
      } else {
        _state = EventsState.error;
        _errorMessage = response.data['message'];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error: $e");
      _state = EventsState.error;
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}

enum EventsState { initial, loading, loaded, error }
