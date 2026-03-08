import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/tabs/location.dart';
import 'package:event_hub/features/home/presentation/tabs/nearby_events_screen.dart';
import 'package:event_hub/features/home/presentation/tabs/notification_screen.dart';
import 'package:event_hub/features/widgets/category.dart';
import 'package:event_hub/features/widgets/filter_button.dart';
import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/features/widgets/upcoming_event_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void goToAllEvents(List<EventModel> events, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NearbyEventsScreen(allEvents: events, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final user = context.watch<UserProvider>();
    final eventProvider = context.watch<EventProvider>();
    final events = eventProvider.filteredEvents;

    final upcomingEvents = events.take(5).toList();
    final nearbyEvents = events;
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Location(),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icon/location.svg',
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${locale.helloHome} ${user.name}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                        icon: SvgPicture.asset(
                          'assets/icon/bell.svg',
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: Searchbarwidget(
                        controller: searchController,
                        onChanged: (value) {
                          eventProvider.setSearchQuery(value);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Filterbutton(),
                  ],
                ),

                const SizedBox(height: 10),

                const Category(),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.upcomingEvents,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          goToAllEvents(upcomingEvents, locale.upcomingEvents),
                      child: Text(
                        locale.seeAll,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 300,
                  child: upcomingEvents.isEmpty
                      ? const Center(child: Text("No Events Found"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingEvents.length,
                          itemBuilder: (context, index) {
                            return UpcomingEventCard(
                              event: upcomingEvents[index],
                            );
                          },
                        ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.nearbyEvents,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          goToAllEvents(nearbyEvents, locale.nearbyEvents),
                      child: Text(
                        locale.seeAll,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: nearbyEvents.length,
                  itemBuilder: (context, index) {
                    return NearbyEventCard(event: nearbyEvents[index]);
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
