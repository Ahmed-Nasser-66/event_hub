import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/model/ticket_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TicketProvider extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  void changeTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  String _searchQuery = "";

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  String _generateRandomTime() {
    final random = Random();

    int hour = random.nextInt(11) + 9;
    int minute = random.nextBool() ? 0 : 30;

    String period = hour >= 12 ? "PM" : "AM";

    int displayHour = hour > 12 ? hour - 12 : hour;

    String minuteString = minute == 0 ? "00" : "30";

    return "$displayHour:$minuteString $period";
  }

  final List<TicketModel> _tickets = [];

  void addTicketFromEvent(EventModel event, int count) {
    int index = _tickets.indexWhere((t) => t.title == event.title);

    if (index != -1) {
      _tickets[index] = TicketModel(
        title: event.title,
        date: event.datetime,
        category: event.category,
        isUpcoming: true,
        bookingId: _tickets[index].bookingId,
        location: event.location,
        image: event.imagepath,
        section: _tickets[index].section,
        row: _tickets[index].row,
        time: _tickets[index].time,
        ticketsCount: count,
        price: "\$${event.price * count}",
      );
    } else {
      final random = Random();

      final newTicket = TicketModel(
        title: event.title,
        date: event.datetime,
        category: event.category,
        isUpcoming: true,
        bookingId: "${random.nextInt(9000000) + 1000000}",
        location: event.location,
        image: event.imagepath,

        section: (random.nextInt(20) + 1).toString(),
        row: (random.nextInt(15) + 1).toString(),

        time: _generateRandomTime(),
        ticketsCount: count,
        price: "\$${event.price * count}",
      );

      _tickets.insert(0, newTicket);
    }

    notifyListeners();
  }

  List<TicketModel> get comingSoonEvents {
    final upcoming = _tickets.where((e) => e.isUpcoming).toList();
    final startMatches = upcoming
        .where(
          (event) =>
              event.title.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    final containsMatches = upcoming
        .where(
          (event) =>
              event.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
              !event.title.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    return [...startMatches, ...containsMatches];
  }

  List<TicketModel> get historyEvents {
    final history = _tickets.where((e) => !e.isUpcoming).toList();
    final startMatches = history
        .where(
          (event) =>
              event.title.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    final containsMatches = history
        .where(
          (event) =>
              event.title.toLowerCase().contains(_searchQuery.toLowerCase()) &&
              !event.title.toLowerCase().startsWith(_searchQuery.toLowerCase()),
        )
        .toList();

    return [...startMatches, ...containsMatches];
  }
}
