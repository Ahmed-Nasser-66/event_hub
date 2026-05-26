import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/event_details_skeleton.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_details_model.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:event_hub/providers/favorite_provider.dart';
import 'package:event_hub/providers/notification_provider.dart';
import 'package:event_hub/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  int ticketCount = 1;
  TextEditingController ticketController = TextEditingController(text: "1");

  EventDetailsModel? _details;
  bool _isLoadingDetails = false;

  @override
  void initState() {
    super.initState();
    ticketController.text = "1";
    _loadEventDetails();
  }

  @override
  void dispose() {
    ticketController.dispose();
    super.dispose();
  }

  Future<void> _loadEventDetails() async {
    setState(() => _isLoadingDetails = true);

    final provider = context.read<EventProvider>();
    final data = await provider.fetchEventDetails(widget.event.id);

    if (mounted) {
      setState(() {
        _details = data;
        _isLoadingDetails = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final eventProvider = context.read<EventProvider>();
    final userProvider = context.read<UserProvider>();
    final event = _details?.event ?? widget.event;

    final String category = widget.event.category ??
        eventProvider.categoryName(widget.event.categoryId);

    double totalPrice = (event.price ?? 0) * ticketCount;

    final lightGreyColor = AppColors.cardGrey.withAlpha(128);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      event.imageUrl ?? '',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppAssets.event,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.35,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      top: 40,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Consumer<FavoriteProvider>(
                        builder: (context, favProvider, child) {
                          bool isFav = favProvider.isExist(widget.event);

                          return GestureDetector(
                            onTap: () {
                              favProvider.toggleFavorite(
                                widget.event,
                                userProvider.email,
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.white.withAlpha(230),
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? AppColors.red : AppColors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.secondary),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.transparent,
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.black,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                event.location,
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.access_time,
                              color: AppColors.black,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              event.date != null
                                  ? DateFormat('dd MMM, yyyy')
                                      .format(event.date!)
                                  : '',
                              style: const TextStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          locale.aboutEvent,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_isLoadingDetails)
                          const EventDetailsSkeleton()
                        else
                          Text(
                            event.description.isNotEmpty
                                ? event.description
                                : locale.eventDetailsDescription,
                            style: const TextStyle(
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    locale.speakers,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: _isLoadingDetails
                      ? const EventDetailsSkeleton()
                      : (_details?.speakers.isEmpty ?? true)
                          ? Text(locale.eventDetailsDescription)
                          : Column(
                              children: _details!.speakers.map((speaker) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            "https://eventhub.huma-volve.com/storage/${speaker.profilePicture}",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              AppAssets.speaker,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.speakerName,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: AppColors.black),
                                            ),
                                            Text(
                                              speaker.name,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.black),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              locale.topic,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: AppColors.black),
                                            ),
                                            Text(
                                              speaker.sessionTitle ?? '',
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Sponsors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: _isLoadingDetails
                      ? const EventDetailsSkeleton()
                      : (_details?.sponsors.isEmpty ?? true)
                          ? Text(locale.eventDetailsDescription)
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _details!.sponsors.map((s) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        color: AppColors.white,
                                        child: Image.network(
                                          "https://eventhub.huma-volve.com/storage/${s.logo}",
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            AppAssets.sponsors,
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withAlpha(128),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "${totalPrice.toStringAsFixed(2)} EGP",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.orange),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          int value = int.tryParse(ticketController.text) ?? 1;
                          if (value > 1) {
                            value--;
                            ticketController.text = value.toString();
                            setState(() => ticketCount = value);
                          }
                        },
                        icon: const Icon(Icons.remove, size: 18),
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: ticketController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          onChanged: (value) {
                            int newValue = int.tryParse(value) ?? 1;
                            if (newValue < 1) newValue = 1;
                            setState(() => ticketCount = newValue);
                          },
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          int value = int.tryParse(ticketController.text) ?? 1;
                          value++;
                          ticketController.text = value.toString();
                          setState(() => ticketCount = value);
                        },
                        icon: const Icon(Icons.add, size: 18),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        int count = int.tryParse(ticketController.text) ?? 1;

                        // التعديل هنا: مررنا الـ userProvider.email كباراميتر ثالث مع إضافة await
                        await context.read<TicketProvider>().addTicketFromEvent(
                              widget.event,
                              count,
                              userProvider.email,
                            );

                        context
                            .read<NotificationProvider>()
                            .addLocalNotification(
                              "Booking Confirmed",
                              "You booked ${widget.event.title} ($count tickets)",
                              image: widget.event.imageUrl,
                            );

                        await context
                            .read<NotificationProvider>()
                            .saveNotifications(userProvider.email);

                        if (!mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${locale.bookNow} $count"),
                            backgroundColor: AppColors.green,
                          ),
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        foregroundColor: AppColors.secondary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        locale.bookNow,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSpeakerCard(
      BuildContext context, String name, String topic, String imagePath) {
    final locale = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.speakerName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.black),
              ),
              Text(name,
                  style: const TextStyle(fontSize: 13, color: AppColors.black)),
              const SizedBox(height: 5),
              Text(
                locale.topic,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.black),
              ),
              Text(topic,
                  style: const TextStyle(fontSize: 13, color: AppColors.black)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSponsorImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: AppColors.white,
        child: Image.asset(
          imagePath,
          width: 70,
          height: 70,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
