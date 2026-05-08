import 'package:event_hub/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<EventModel> _favoriteEvents = [];

  List<EventModel> get favoriteEvents => _favoriteEvents;

  Future<void> toggleFavorite(
    EventModel event,
    String userEmail,
  ) async {
    if (isExist(event)) {
      _favoriteEvents.removeWhere(
        (e) => e.id == event.id,
      );

      event.isFavorite = false;
    } else {
      _favoriteEvents.add(event);

      event.isFavorite = true;
    }

    await saveFavorites(userEmail);

    notifyListeners();
  }

  bool isExist(EventModel event) {
    return _favoriteEvents.any(
      (e) => e.id == event.id,
    );
  }

  Future<void> saveFavorites(
    String userEmail,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIds = _favoriteEvents.map((e) => e.id.toString()).toList();

    await prefs.setStringList(
      "favorites_$userEmail",
      favoriteIds,
    );
  }

  Future<void> loadFavorites(
    List<EventModel> allEvents,
    String userEmail,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteIds = prefs.getStringList(
          "favorites_$userEmail",
        ) ??
        [];

    _favoriteEvents.clear();

    for (var event in allEvents) {
      if (favoriteIds.contains(
        event.id.toString(),
      )) {
        event.isFavorite = true;

        _favoriteEvents.add(event);
      } else {
        event.isFavorite = false;
      }
    }

    notifyListeners();
  }
}
