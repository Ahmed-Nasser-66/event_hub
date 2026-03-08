import 'package:event_hub/features/home/presentation/tabs/favorite_tab.dart';
import 'package:event_hub/features/home/presentation/tabs/home_tab.dart';
import 'package:event_hub/features/ticket/presentation/tabs/ticket_tab.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:event_hub/features/profile/profile_tab.dart';
import '../../../core/theme/app_color.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  int currentIndex = 0;
  

  final List<Widget> pages = [
    HomeTab(),
    TicketTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.secondary,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.confirmation_number),
            label: l10n.tickets,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: l10n.favorite,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}
