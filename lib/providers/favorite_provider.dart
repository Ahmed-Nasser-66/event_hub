import 'package:flutter/material.dart';
import 'package:event_hub/model/event_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<EventModel> _favoriteEvents = [];

  List<EventModel> get favoriteEvents => _favoriteEvents;

  void toggleFavorite(EventModel event) {
    if (_favoriteEvents.contains(event)) {
      _favoriteEvents.remove(event);
      event.isFavorite = false;
    } else {
      _favoriteEvents.add(event);
      event.isFavorite = true;
    }
    notifyListeners();
  }

  bool isExist(EventModel event) {
    return _favoriteEvents.contains(event);
  }
}
