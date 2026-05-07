import 'dart:ui';

import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class TicketDetailsScreen extends StatelessWidget {
  TicketDetailsScreen({super.key, required this.ticket});

  final TicketModel ticket;
  final GlobalKey ticketKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    DateTime parsedDate = DateTime.parse(ticket.date);

    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    String formattedStartTime = DateFormat(
      'hh:mm a',
    ).format(DateTime.parse(ticket.startTime));

    String formattedEndTime = DateFormat(
      'hh:mm a',
    ).format(DateTime.parse(ticket.endTime));
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
          backgroundColor: AppColors.grey,
          elevation: 0,
          leading: CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: RepaintBoundary(
            key: ticketKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          ticket.image.startsWith('http')
                              ? ticket.image
                              : 'https://via.placeholder.com/300',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          ticket.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    l10n.venue,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ticket.location,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.section,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ticket.section,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.row,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              ticket.row,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.date,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.time,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "$formattedStartTime - $formattedEndTime",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.numberOfTickets,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${ticket.ticketsCount}",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.price,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ticket.price.replaceAll("\$", "EGP "),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        l10n.bookingId,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: ticket.bookingId),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.bookingIdCopied),
                              backgroundColor: AppColors.green,
                            ),
                          );
                        },
                        child: const Icon(Icons.copy, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ticket.bookingId,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Center(
                    child: QrImageView(
                      data: '''{
                        "title": "${ticket.title}",
                        "date": "$formattedDate",
                        "time": "$formattedStartTime - $formattedEndTime",           
                        "location": "${ticket.location}",
                        "price": "${ticket.price}",
                        "section": "${ticket.section}",
                        "row": "${ticket.row}",
                        "tickets": "${ticket.ticketsCount}",
                        "category": "${ticket.category}",
                        "bookingId": "${ticket.bookingId}"
                        }''',
                      size: 190,
                      backgroundColor: AppColors.white,
                      version: QrVersions.auto,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);

                        try {
                          if (ticketKey.currentContext == null) return;

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.orange,
                              ),
                            ),
                          );
                          await Future.delayed(
                            const Duration(milliseconds: 50),
                          );

                          if (!context.mounted) return;

                          final boundary = ticketKey.currentContext!
                              .findRenderObject() as RenderRepaintBoundary;

                          final image = await boundary.toImage(pixelRatio: 3);

                          final byteData = await image.toByteData(
                            format: ImageByteFormat.png,
                          );

                          final pngBytes = byteData!.buffer.asUint8List();

                          await Gal.putImageBytes(pngBytes);

                          if (!context.mounted) return;

                          Navigator.pop(context);

                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(l10n.ticketSavedToGallery),
                              backgroundColor: AppColors.green,
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          Navigator.pop(context);

                          messenger.showSnackBar(
                            SnackBar(
                              content: Text("Error: $e"),
                              backgroundColor: AppColors.red,
                            ),
                          );
                        }
                      },
                      child: Text(
                        l10n.downloadTicket,
                        style: TextStyle(color: AppColors.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
