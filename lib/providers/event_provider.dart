import 'package:event_hub/model/event_data.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EventProvider extends ChangeNotifier {
  String _selectedCategory = "All";
  String _searchQuery = "";

  bool _isSortedByPrice = false;
  bool _isSortedByDate = false;
  bool _isSortedBySmartChoice = false;

  // ✅ user location
  double? _userLat;
  double? _userLng;

  // ✅ أضف هذه المتغيرات الجديدة
  bool _isLoading = false;
  String? _errorMessage;
  EventsState _state = EventsState.initial;

  String get selectedCategory => _selectedCategory;

  // ✅ Getters جديدة
  bool get isLoading => _isLoading;
  bool get hasError => _state == EventsState.error;
  String? get errorMessage => _errorMessage;
  EventsState get state => _state;

  // ================== EXISTING FILTER ==================
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
        int dateComparison = a.date.compareTo(b.date);
        if (dateComparison == 0) {
          return a.price.compareTo(b.price);
        }
        return dateComparison;
      });
    } else if (_isSortedByPrice) {
      result.sort((a, b) => a.price.compareTo(b.price));
    } else if (_isSortedByDate) {
      result.sort((a, b) => a.date.compareTo(b.date));
    }

    return result;
  }

  // ================== FILTERED UPCOMING EVENTS (مع الترتيب) ==================
  List<EventModel> get filteredUpcomingEvents {
    // 1. أولاً: طبق الفلتر (التصنيف + البحث)
    final filtered = EventRepository.allEvents.where((event) {
      final matchesCategory =
          _selectedCategory == "All" || event.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.location.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    // 2. ثانياً: صفي إلى الأحداث المستقبلية فقط
    final now = DateTime.now();
    final upcoming =
        filtered.where((event) => event.date.isAfter(now)).toList();

    // 3. ✅ تطبيق الترتيب حسب اختيار المستخدم من الفلتر
    if (_isSortedBySmartChoice) {
      upcoming.sort((a, b) {
        int dateComparison = a.date.compareTo(b.date);
        if (dateComparison == 0) {
          return a.price.compareTo(b.price);
        }
        return dateComparison;
      });
    } else if (_isSortedByPrice) {
      upcoming.sort((a, b) => a.price.compareTo(b.price));
    } else if (_isSortedByDate) {
      upcoming.sort((a, b) => a.date.compareTo(b.date));
    } else {
      // الترتيب الافتراضي: حسب التاريخ (الأقرب أولاً)
      upcoming.sort((a, b) => a.date.compareTo(b.date));
    }

    return upcoming.take(5).toList();
  }

  // ================== FILTERED NEARBY EVENTS (مع الترتيب) ==================
  List<EventModel> get filteredNearbyEvents {
    // 1. إذا لم يوجد موقع، أرجع قائمة فارغة
    if (_userLat == null) return [];

    // 2. طبق الفلتر (التصنيف + البحث)
    final filtered = EventRepository.allEvents.where((event) {
      final matchesCategory =
          _selectedCategory == "All" || event.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          event.location.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();

    // 3. صفي إلى الأحداث المستقبلية فقط
    final now = DateTime.now();
    final upcoming =
        filtered.where((event) => event.date.isAfter(now)).toList();

    // 4. ✅ تطبيق الترتيب حسب اختيار المستخدم من الفلتر
    if (_isSortedBySmartChoice) {
      upcoming.sort((a, b) {
        int dateComparison = a.date.compareTo(b.date);
        if (dateComparison == 0) {
          return a.price.compareTo(b.price);
        }
        return dateComparison;
      });
    } else if (_isSortedByPrice) {
      upcoming.sort((a, b) => a.price.compareTo(b.price));
    } else if (_isSortedByDate) {
      upcoming.sort((a, b) => a.date.compareTo(b.date));
    } else {
      // ✅ الترتيب الافتراضي: حسب المسافة (الأقرب مكانياً أولاً)
      upcoming.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
    }

    return upcoming.take(5).toList();
  }

  // ================== SET LOCATION ==================
  void setUserLocation(double lat, double lng) {
    _userLat = lat;
    _userLng = lng;

    for (var event in EventRepository.allEvents) {
      event.distance = Geolocator.distanceBetween(
        _userLat!,
        _userLng!,
        event.latitude,
        event.longitude,
      );
    }

    notifyListeners();
  }

  // ================== UPCOMING (OLD - Keep for compatibility) ==================
  List<EventModel> get upcomingEvents {
    final now = DateTime.now();

    final events = EventRepository.allEvents
        .where((event) => event.date.isAfter(now))
        .toList();

    events.sort((a, b) => a.date.compareTo(b.date));

    return events.take(5).toList();
  }

  // ================== NEARBY (OLD - Keep for compatibility) ==================
  List<EventModel> get nearbyEvents {
    if (_userLat == null) return [];

    final events = EventRepository.allEvents
        .where((event) => event.date.isAfter(DateTime.now()))
        .toList();

    events.sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));

    return events.take(5).toList();
  }

  // ================== REFRESH METHODS ==================
  Future<void> refreshEvents() async {
    _isLoading = true;
    _state = EventsState.loading;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      if (_userLat != null && _userLng != null) {
        for (var event in EventRepository.allEvents) {
          event.distance = Geolocator.distanceBetween(
            _userLat!,
            _userLng!,
            event.latitude,
            event.longitude,
          );
        }
      }

      _state = EventsState.loaded;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _state = EventsState.error;
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadEvents() async {
    await refreshEvents();
  }

  void resetEvents() {
    _selectedCategory = "All";
    _searchQuery = "";
    _isSortedByPrice = false;
    _isSortedByDate = false;
    _isSortedBySmartChoice = false;
    notifyListeners();
  }

  // ================== SORT ==================
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

  // ================== FILTER ==================
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}

// ✅ Enum خارج الكلاس
enum EventsState { initial, loading, loaded, error }
