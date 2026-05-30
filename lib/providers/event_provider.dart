import 'package:event_hub/core/api/events_service.dart';
import 'package:event_hub/core/api/local_notification_service.dart';
import 'package:event_hub/model/event_details_model.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'favorite_provider.dart';

class CategoryItem {
  final int id;
  final String name;
  final String slug;

  CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
  });
}

class EventProvider extends ChangeNotifier {
  final EventsService _eventsService = EventsService();

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

  List<EventModel> _upcomingEvents = [];
  List<EventModel> _nearbyEvents = [];

  List<CategoryItem> _categories = [];

  int? get selectedCategoryId => _selectedCategoryId;

  List<CategoryItem> get categories => _categories;

  bool get isLoading => _isLoading;

  bool get hasError => _state == EventsState.error;

  String? get errorMessage => _errorMessage;

  EventsState get state => _state;

  List<EventModel> get allEvents => _allEvents;

  List<EventModel> get upcomingEvents => _upcomingEvents;

  List<EventModel> get nearbyEvents => _nearbyEvents;

  String categoryName(int? id) {
    if (id == null) return "Unknown";

    final category = _categories.firstWhere(
      (c) => c.id == id,
      orElse: () => CategoryItem(
        id: 0,
        name: "Unknown",
        slug: "",
      ),
    );

    return category.name;
  }

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
        return event.title.toLowerCase().startsWith(
              _searchQuery.toLowerCase(),
            );
      }).toList();

      final containsMatches = eventsByCategory.where((event) {
        return event.title.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) &&
            !event.title.toLowerCase().startsWith(
                  _searchQuery.toLowerCase(),
                );
      }).toList();

      result = [
        ...startMatches,
        ...containsMatches,
      ];
    }

    if (_isSortedBySmartChoice) {
      result.sort((a, b) {
        int dateCompare = (a.date ?? DateTime.now()).compareTo(
          b.date ?? DateTime.now(),
        );
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

  List<EventModel> get filteredUpcomingEvents {
    List<EventModel> events = _upcomingEvents.where((event) {
      return _selectedCategoryId == null ||
          event.categoryId == _selectedCategoryId;
    }).toList();

    if (_searchQuery.isNotEmpty) {
      events = events.where((event) {
        return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_isSortedBySmartChoice) {
      events.sort((a, b) {
        int dateCompare =
            (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now());
        if (dateCompare == 0) {
          return (a.price ?? 0).compareTo(b.price ?? 0);
        }
        return dateCompare;
      });
    } else if (_isSortedByPrice) {
      events.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
    } else if (_isSortedByDate) {
      events.sort((a, b) =>
          (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
    }

    return events;
  }

  List<EventModel> get filteredNearbyEvents {
    List<EventModel> events = _nearbyEvents.where((event) {
      return _selectedCategoryId == null ||
          event.categoryId == _selectedCategoryId;
    }).toList();

    if (_searchQuery.isNotEmpty) {
      events = events.where((event) {
        return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_isSortedBySmartChoice) {
      events.sort((a, b) {
        int dateCompare =
            (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now());
        if (dateCompare == 0) {
          return (a.price ?? 0).compareTo(b.price ?? 0);
        }
        return dateCompare;
      });
    } else if (_isSortedByPrice) {
      events.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
    } else if (_isSortedByDate) {
      events.sort((a, b) =>
          (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));
    }

    return events;
  }

  void _calculateDistances() {
    if (_userLat == null || _userLng == null) return;

    for (var event in _allEvents) {
      if (event.latitude != null && event.longitude != null) {
        event.distance = Geolocator.distanceBetween(
          _userLat!,
          _userLng!,
          event.latitude!,
          event.longitude!,
        );
      }
    }
  }

  void setUserLocation(double lat, double lng) {
    _userLat = lat;
    _userLng = lng;
    _calculateDistances();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

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

  Future<void> fetchEventsByCategory(String slug) async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _eventsService.getEventsByCategory(slug);
      if (response.data['success'] == true) {
        final List eventsJson = response.data['message']['data'] ?? [];
        _allEvents = eventsJson.map((e) => EventModel.fromJson(e)).toList();
        _calculateDistances();
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint("❌ Error: $e");
      notifyListeners();
    }
  }

  Future<EventDetailsModel?> fetchEventDetails(int eventId) async {
    try {
      return await _eventsService.getEventDetails(eventId);
    } catch (e) {
      debugPrint("❌ Error fetching event details: $e");
      return null;
    }
  }

  Future<void> refreshEvents({
    FavoriteProvider? favoriteProvider,
    String? userEmail,
  }) async {
    _selectedCategoryId = null;

    if (_isLoading) return;

    _isLoading = true;
    _state = EventsState.loading;
    notifyListeners();

    try {
      final response = await _eventsService.getAppHome();

      if (response.data['success'] == true) {
        final data = response.data['message'];

        final List categoriesJson = data['categories'] ?? [];
        final List upcomingJson = data['upcoming_events'] ?? [];
        final List nearbyJson = data['nearby_events'] ?? [];

        _categories = categoriesJson.map((e) {
          return CategoryItem(id: e['id'], name: e['name'], slug: e['slug']);
        }).toList();

        _upcomingEvents =
            upcomingJson.map((e) => EventModel.fromJson(e)).toList();
        _nearbyEvents = nearbyJson.map((e) => EventModel.fromJson(e)).toList();

        final allEventsResponse = await _eventsService.getAllEvents();

        if (allEventsResponse.data['success'] == true) {
          final List allEventsJson =
              allEventsResponse.data['message']['data'] ?? [];

          _allEvents =
              allEventsJson.map((e) => EventModel.fromJson(e)).toList();
        }

        if (favoriteProvider != null && userEmail != null) {
          await favoriteProvider.loadFavorites(_allEvents, userEmail);
        }

        _calculateDistances();
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

  Future<bool> bookEvent(int eventId) async {
    try {
      final response = await _eventsService.bookEvent(eventId);

      if (response.data['success'] == true) {
        await LocalNotificationService.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: 'Booking Confirmed! 🎉',
          body: 'Your spot is secured. Get ready for an amazing experience!',
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("❌ Error booking event: $e");
      return false;
    }
  }
}

enum EventsState {
  initial,
  loading,
  loaded,
  error,
}
