import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/ticket/presentation/tabs/ticket_tab.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventBookingScreen extends StatefulWidget {
  final EventModel event;
  const EventBookingScreen({super.key, required this.event});

  @override
  State<EventBookingScreen> createState() => _EventBookingScreenState();
}

class _EventBookingScreenState extends State<EventBookingScreen> {
  int ticketCount = 1;
  TextEditingController ticketController = TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
    ticketController.text = "1";
  }

  @override
  void dispose() {
    ticketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        title: Text(
          l10n.eventTitle,
          style: const TextStyle(color: AppColors.black),
        ),
        backgroundColor: AppColors.grey,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),

              // ✅ التعديل الوحيد (fix crash)
              child: Image.network(
                widget.event.imageUrl ?? '',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_month, color: AppColors.orange),
                const SizedBox(width: 8),
                Text(
                  DateFormat('dd MMM, yyyy')
                      .format(widget.event.date ?? DateTime.now()),
                  style: const TextStyle(color: AppColors.lightGrey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.event.location,
                    style: const TextStyle(color: AppColors.lightGrey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: AppColors.cardGrey),
            const SizedBox(height: 20),
            Text(
              l10n.aboutEvent,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.event.description,
              style: const TextStyle(
                color: AppColors.lightGrey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Select Tickets",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
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
                          showCursor: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isCollapsed: true,
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              setState(() => ticketCount = 1);
                              return;
                            }

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
                const Spacer(),
                Text(
                  "${ticketCount * (widget.event.price ?? 0)} EGP",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    int count = int.tryParse(ticketController.text) ?? 1;

                    Provider.of<TicketProvider>(context, listen: false)
                        .addTicketFromEvent(widget.event, count);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicketTab()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Confirm & Buy (${ticketCount * (widget.event.price ?? 0)} EGP)",
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
