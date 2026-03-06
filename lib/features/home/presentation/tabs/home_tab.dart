import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/tabs/location.dart';
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

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final user = context.watch<UserProvider>();

    final eventProvider = context.watch<EventProvider>();
    final List<EventModel> displayedEvents = eventProvider.filteredEvents;

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

                const SizedBox(height: 5),
                // Categories Filter
                const Category(),
                const SizedBox(height: 5),

                SizedBox(
                  height: 340,
                  child: displayedEvents.isEmpty
                      ? const Center(child: Text("No Events Found"))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          scrollDirection: Axis.horizontal,
                          itemCount: displayedEvents.length,
                          itemBuilder: (context, index) {
                            return UpcomingEventCard(
                              event: displayedEvents[index],
                            );
                          },
                        ),
                ),

                const SizedBox(height: 5),

                // Nearby Events
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
                      onPressed: () {},
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

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedEvents.length,
                  itemBuilder: (context, index) {
                    return NearbyEventCard(event: displayedEvents[index]);
                  },
                ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
