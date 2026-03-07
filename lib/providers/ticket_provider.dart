import 'package:event_hub/core/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:event_hub/model/ticket_model.dart';

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

  final List<TicketModel> _tickets = [
    TicketModel(
      title: "Music Festival",
      date: "12 May 2026",
      category: "Music",
      isUpcoming: true,
      bookingId: "598746875",
      location: "New Cairo",
      image: AppAssets.party1,
      section: "14",
      row: "12",
      time: "12:00 AM",
      ticketsCount: 9,
      price: "\$10",
    ),

    TicketModel(
      title: "Tech Conference",
      date: "20 May 2026",
      category: "Technology",
      isUpcoming: false,
      bookingId: "789654123",
      location: "Smart Village",
      image: AppAssets.lama,
      section: "18",
      row: "16",
      time: "06:00 PM",
      ticketsCount: 8,
      price: "\$90",
    ),
    TicketModel(
      title: "Startup Meetup",
      date: "15 July 2026",
      category: "Business",
      isUpcoming: true,
      bookingId: "112233445",
      location: "New Cairo",
      image: AppAssets.party,
      section: "6",
      row: "9",
      time: "02:00 PM",
      ticketsCount: 3,
      price: "\$25",
    ),

    TicketModel(
      title: "AI Conference",
      date: "22 July 2026",
      category: "Technology",
      isUpcoming: true,
      bookingId: "223344556",
      location: "Smart Village",
      image: AppAssets.party1,
      section: "12",
      row: "7",
      time: "11:00 AM",
      ticketsCount: 2,
      price: "\$120",
    ),

    TicketModel(
      title: "Gaming Championship",
      date: "30 July 2026",
      category: "Gaming",
      isUpcoming: true,
      bookingId: "334455667",
      location: "New Capital",
      image: AppAssets.setting,
      section: "20",
      row: "4",
      time: "05:00 PM",
      ticketsCount: 4,
      price: "\$60",
    ),

    TicketModel(
      title: "Marketing Summit",
      date: "10 August 2026",
      category: "Business",
      isUpcoming: true,
      bookingId: "445566778",
      location: "Nasr City",
      image: AppAssets.lama,
      section: "3",
      row: "10",
      time: "09:00 AM",
      ticketsCount: 5,
      price: "\$40",
    ),

    TicketModel(
      title: "Music Night",
      date: "18 August 2026",
      category: "Music",
      isUpcoming: true,
      bookingId: "556677889",
      location: "Zamalek",
      image: AppAssets.party1,
      section: "14",
      row: "2",
      time: "08:30 PM",
      ticketsCount: 2,
      price: "\$70",
    ),

    TicketModel(
      title: "Education Expo",
      date: "5 September 2026",
      category: "Education",
      isUpcoming: false,
      bookingId: "667788990",
      location: "Maadi",
      image: AppAssets.special,
      section: "7",
      row: "11",
      time: "01:00 PM",
      ticketsCount: 6,
      price: "\$15",
    ),

    TicketModel(
      title: "Developers Meetup",
      date: "12 September 2026",
      category: "Technology",
      isUpcoming: false,
      bookingId: "778899001",
      location: "Smart Village",
      image: AppAssets.sponsors1,
      section: "16",
      row: "5",
      time: "04:00 PM",
      ticketsCount: 3,
      price: "\$35",
    ),

    TicketModel(
      title: "Art Workshop",
      date: "20 September 2026",
      category: "Art",
      isUpcoming: false,
      bookingId: "889900112",
      location: "Downtown Cairo",
      image: AppAssets.ellipse1,
      section: "2",
      row: "6",
      time: "12:00 PM",
      ticketsCount: 2,
      price: "\$20",
    ),

    TicketModel(
      title: "Digital Marketing Bootcamp",
      date: "28 September 2026",
      category: "Business",
      isUpcoming: false,
      bookingId: "990011223",
      location: "Heliopolis",
      image: AppAssets.ellipse4,
      section: "9",
      row: "8",
      time: "03:30 PM",
      ticketsCount: 4,
      price: "\$50",
    ),

    TicketModel(
      title: "Future Tech Expo",
      date: "10 October 2026",
      category: "Technology",
      isUpcoming: true,
      bookingId: "101112131",
      location: "New Administrative Capital",
      image: AppAssets.ellipse3,
      section: "21",
      row: "1",
      time: "10:00 AM",
      ticketsCount: 7,
      price: "\$95",
    ),
    TicketModel(
      title: "Art Exhibition",
      date: "10 April 2026",
      category: "Art",
      isUpcoming: false,
      bookingId: "456321987",
      location: "Zamalek",
      image: AppAssets.ellipse2,
      section: "10",
      row: "12",
      time: "10:00 AM",
      ticketsCount: 2,
      price: "\$150",
    ),

    TicketModel(
      title: "Business Summit",
      date: "5 June 2026",
      category: "Business",
      isUpcoming: true,
      bookingId: "321654987",
      location: "Nasr City",
      image: AppAssets.ellipse1,
      section: "5",
      row: "8",
      time: "11:30 AM",
      ticketsCount: 5,
      price: "\$40",
    ),

    TicketModel(
      title: "Gaming Expo",
      date: "18 June 2026",
      category: "Gaming",
      isUpcoming: true,
      bookingId: "951753852",
      location: "New Capital",
      image: AppAssets.hello,
      section: "15",
      row: "7",
      time: "05:15 PM",
      ticketsCount: 9,
      price: "\$80",
    ),
  ];

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
