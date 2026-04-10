import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/ticket/presentation/tabs/ticket_tab.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
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
              child: Image.asset(
                widget.event.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: AppColors.cardGrey,
                  child: const Icon(Icons.broken_image,
                      size: 50, color: AppColors.lightGrey),
                ),
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
                  DateFormat('dd MMM, yyyy').format(widget.event.date),
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
              style: const TextStyle(color: AppColors.lightGrey, height: 1.5),
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
                _buildQtyBtn(Icons.remove, () {
                  if (ticketCount > 1) setState(() => ticketCount--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "$ticketCount",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
                _buildQtyBtn(Icons.add, () => setState(() => ticketCount++)),
                const Spacer(),
                Text(
                  "${ticketCount * widget.event.price} EGP",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<TicketProvider>(context, listen: false)
                      .addTicketFromEvent(widget.event, ticketCount);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TicketTab()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: Text(
                  "Confirm & Buy (${ticketCount * widget.event.price} EGP)",
                  style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardGrey),
        ),
        child: Icon(icon, size: 20, color: AppColors.black),
      ),
    );
  }
}
