import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/ticket/presentation/tabs/ticket_details_screen.dart';
import 'package:event_hub/features/ticket/presentation/widget/ticket_card.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/ticket_provider.dart';
import 'package:event_hub/providers/user_provider.dart';
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final userEmail = context.read<UserProvider>().email;
      context.read<TicketProvider>().loadTickets(userEmail);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 300),
                              child: Text(
                                AppLocalizations.of(context)!.noTicketsyet,
                                style: const TextStyle(
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
                              onDelete: () async {
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: AppColors.red
                                                  .withValues(alpha: 0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: AppColors.red,
                                              size: 32,
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            "Delete Ticket?",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.secondary,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            "Are you sure you want to delete\n${event.title}?",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: AppColors.lightGrey,
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          const Text(
                                            "This action cannot be undone.",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.lightGrey,
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 45,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          AppColors.cardGrey,
                                                      foregroundColor:
                                                          AppColors.secondary,
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: SizedBox(
                                                  height: 45,
                                                  child: ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    label: const Text("Delete"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      foregroundColor:
                                                          Colors.white,
                                                      elevation: 0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );

                                if (result != true) return;
                                if (!context.mounted) return;
                                final email =
                                    context.read<UserProvider>().email;

                                await context
                                    .read<TicketProvider>()
                                    .deleteTicket(
                                      event.bookingId,
                                      email,
                                    );
                              },
                              title: event.title,
                              date: event.date,
                              startTime: event.startTime,
                              endTime: event.endTime,
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
