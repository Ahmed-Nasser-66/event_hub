import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TicketCard extends StatelessWidget {
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String location;
  final String price;
  final String tickets;
  final String image;
  final VoidCallback onTap;
  final String bookingId;
  final VoidCallback onDelete;
  const TicketCard({
    super.key,
    required this.title,
    required this.date,
    required this.location,
    required this.price,
    required this.tickets,
    required this.image,
    required this.onTap,
    required this.bookingId,
    required this.startTime,
    required this.endTime,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    DateTime parsedDate = DateTime.parse(date);

    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    String formattedStartTime = DateFormat(
      'hh:mm a',
    ).format(DateTime.parse(startTime));

    String formattedEndTime = DateFormat(
      'hh:mm a',
    ).format(DateTime.parse(endTime));
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image.startsWith('http')
                        ? image
                        : 'https://via.placeholder.com/300',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$formattedStartTime - $formattedEndTime",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${l10n.tickets} $tickets",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightGrey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      price.replaceAll("\$", "EGP "),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Text(
                  l10n.bookingCode,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
                Text(
                  bookingId,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: bookingId));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.bookingIdCopied),
                        backgroundColor: AppColors.green,
                      ),
                    );
                  },
                  child: const Icon(Icons.copy, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
