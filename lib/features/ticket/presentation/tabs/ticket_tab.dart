import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/ticket/presentation/tabs/ticket_details_screen.dart';
import 'package:event_hub/features/ticket/presentation/widget/ticket_card.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketTab extends StatefulWidget {
  const TicketTab({super.key});

  @override
  State<TicketTab> createState() => _TicketTabState();
}

class _TicketTabState extends State<TicketTab> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();
    final ticketProvider = context.watch<TicketProvider>();
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.grey,
        body: SafeArea(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Searchbarwidget(
                            controller: searchController,
                            onChanged: (value) {
                              eventProvider.setSearchQuery(value);
                              ticketProvider.setSearchQuery(value);
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: AppColors.orange,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelColor: AppColors.secondary,
                        unselectedLabelColor: AppColors.lightGrey,
                        onTap: (index) {
                          context.read<TicketProvider>().changeTab(index);
                        },
                        tabs: [
                          Tab(text: l10n.comingSoon),
                          Tab(text: l10n.history),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Consumer<TicketProvider>(
                      builder: (context, provider, child) {
                        final events = provider.selectedTab == 0
                            ? provider.comingSoonEvents
                            : provider.historyEvents;

                        if (events.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 300),
                              child: Text(
                                "No Tickets yet!",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightGrey,
                                ),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return TicketCard(
                              title: event.title,
                              date: event.date,
                              time: event.time,
                              location: event.location,
                              price: event.price,
                              tickets: event.ticketsCount.toString(),
                              image: event.image,
                              bookingId: event.bookingId,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        TicketDetailsScreen(ticket: event),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
