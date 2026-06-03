import 'dart:convert';
import 'dart:math';

import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/model/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> saveTickets(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();

    final ticketJson = _tickets.map((ticket) {
      return {
        'title': ticket.title,
        'date': ticket.date,
        'category': ticket.category,
        'isUpcoming': ticket.isUpcoming,
        'bookingId': ticket.bookingId,
        'location': ticket.location,
        'image': ticket.image,
        'section': ticket.section,
        'row': ticket.row,
        'startTime': ticket.startTime,
        'endTime': ticket.endTime,
        'price': ticket.price,
        'ticketsCount': ticket.ticketsCount,
      };
    }).toList();

    await prefs.setString(
      "tickets_$userEmail",
      jsonEncode(ticketJson),
    );
  }

  Future<void> loadTickets(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final ticketsJson = prefs.getString("tickets_$userEmail");

    _tickets.clear();

    if (ticketsJson != null && ticketsJson.isNotEmpty) {
      try {
        final List decoded = jsonDecode(ticketsJson);

        for (var item in decoded) {
          _tickets.add(TicketModel(
            title: item['title'] ?? '',
            date: item['date'] ?? '',
            category: item['category'] ?? '',
            isUpcoming: item['isUpcoming'] ?? true,
            bookingId: item['bookingId'] ?? '',
            location: item['location'] ?? '',
            image: item['image'] ?? '',
            section: item['section'] ?? '',
            row: item['row'] ?? '',
            startTime: item['startTime'] ?? '',
            endTime: item['endTime'] ?? '',
            price: item['price'] ?? '',
            ticketsCount: item['ticketsCount'] ?? 1,
          ));
        }
      } catch (e) {
        debugPrint("❌ Error loading tickets: $e");
      }
    }

    notifyListeners();
  }

  bool hasTicket(String eventTitle) {
    return _tickets.any((t) => t.title == eventTitle);
  }

  Future<void> deleteTicket(
    String bookingId,
    String userEmail,
  ) async {
    _tickets.removeWhere(
      (ticket) => ticket.bookingId == bookingId,
    );

    await saveTickets(userEmail);
    notifyListeners();
  }

  Future<void> addTicketFromEvent(
      EventModel event, int count, String userEmail) async {
    if (_tickets.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final ticketsJson = prefs.getString("tickets_$userEmail");
      if (ticketsJson != null && ticketsJson.isNotEmpty) {
        try {
          final List decoded = jsonDecode(ticketsJson);
          for (var item in decoded) {
            _tickets.add(TicketModel(
              title: item['title'] ?? '',
              date: item['date'] ?? '',
              category: item['category'] ?? '',
              isUpcoming: item['isUpcoming'] ?? true,
              bookingId: item['bookingId'] ?? '',
              location: item['location'] ?? '',
              image: item['image'] ?? '',
              section: item['section'] ?? '',
              row: item['row'] ?? '',
              startTime: item['startTime'] ?? '',
              endTime: item['endTime'] ?? '',
              price: item['price'] ?? '',
              ticketsCount: item['ticketsCount'] ?? 1,
            ));
          }
        } catch (e) {
          debugPrint("❌ Error syncing tickets before add: $e");
        }
      }
    }

    int index = _tickets.indexWhere((t) => t.title == event.title);

    String dateString = (event.date ?? DateTime.now()).toIso8601String();

    if (index != -1) {
      _tickets[index] = TicketModel(
        title: event.title,
        date: dateString,
        category: event.category ?? '',
        isUpcoming: true,
        bookingId: _tickets[index].bookingId,
        location: event.location,
        image: event.imageUrl ?? '',
        section: _tickets[index].section,
        row: _tickets[index].row,
        startTime: _tickets[index].startTime,
        endTime: _tickets[index].endTime,
        ticketsCount: count,
        price: "\$${((event.price ?? 0) * count).toStringAsFixed(2)}",
      );
    } else {
      final random = Random();

      final newTicket = TicketModel(
        title: event.title,
        date: dateString,
        category: event.category ?? '',
        isUpcoming: true,
        bookingId: "${random.nextInt(9000000) + 1000000}",
        location: event.location,
        image: event.imageUrl ?? '',
        section: (random.nextInt(20) + 1).toString(),
        row: (random.nextInt(15) + 1).toString(),
        startTime: event.startTime ?? '',
        endTime: event.endTime ?? '',
        ticketsCount: count,
        price: "\$${((event.price ?? 0) * count).toStringAsFixed(2)}",
      );

      _tickets.insert(0, newTicket);
    }

    await saveTickets(userEmail);

    notifyListeners();
  }

  void clearTicketsOnLogout() {
    _tickets.clear();
    notifyListeners();
  }

  List<TicketModel> get comingSoonEvents {
    final upcoming = _tickets.where((event) {
      DateTime date = DateTime.tryParse(event.date) ?? DateTime.now();
      return date.isAfter(DateTime.now());
    }).toList();

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
      DateTime date = DateTime.tryParse(event.date) ?? DateTime.now();
      return date.isBefore(DateTime.now());
    }).toList();

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
