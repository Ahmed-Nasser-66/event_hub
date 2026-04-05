import 'dart:math';

import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/model/ticket_model.dart';
import 'package:flutter/material.dart';

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

  final List<TicketModel> _tickets = [];

  void addTicketFromEvent(EventModel event, int count) {
    int index = _tickets.indexWhere((t) => t.title == event.title);

    // بنحول الـ DateTime لنص بصيغة ISO عشان نعرف نعمله Parse بسهولة وقت الترتيب
    String dateString = event.datetime.toIso8601String();

    if (index != -1) {
      _tickets[index] = TicketModel(
        title: event.title,
        date: dateString,
        category: event.category,
        isUpcoming: true,
        bookingId: _tickets[index].bookingId,
        location: event.location,
        image: event.imagepath,
        section: _tickets[index].section,
        row: _tickets[index].row,
        time: _tickets[index].time,
        ticketsCount: count,
        price: "\$${(event.price * count).toStringAsFixed(2)}",
      );
    } else {
      final random = Random();

      final newTicket = TicketModel(
        title: event.title,
        date: dateString,
        category: event.category,
        isUpcoming: true,
        bookingId: "${random.nextInt(9000000) + 1000000}",
        location: event.location,
        image: event.imagepath,
        section: (random.nextInt(20) + 1).toString(),
        row: (random.nextInt(15) + 1).toString(),
        time: event.time,
        ticketsCount: count,
        price: "\$${(event.price * count).toStringAsFixed(2)}",
      );

      _tickets.insert(0, newTicket);
    }

    notifyListeners();
  }

  List<TicketModel> get comingSoonEvents {
    final upcoming = _tickets.where((event) {
      DateTime date = DateTime.parse(event.date);
      return date.isAfter(DateTime.now());
    }).toList();

    // 🔥 ترتيب الأحداث: الأقرب تاريخاً يظهر أولاً
    upcoming.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a.date) ?? DateTime.now();
      DateTime dateB = DateTime.tryParse(b.date) ?? DateTime.now();
      return dateA.compareTo(dateB);
    });

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
    final history = _tickets.where((event) {
      DateTime date = DateTime.parse(event.date);
      return date.isBefore(DateTime.now());
    }).toList();
    // ترتيب السجل: الأحدث تاريخاً يظهر أولاً (عكس القادم)
    history.sort((a, b) {
      DateTime dateA = DateTime.tryParse(a.date) ?? DateTime.now();
      DateTime dateB = DateTime.tryParse(b.date) ?? DateTime.now();
      return dateB.compareTo(dateA);
    });

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
