import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/notification_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "homepage");
          },
        ),
      ),
      body: Form(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.notifications,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),

              NotificationCard(
                title: l10n.eventReminder,
                description: l10n.concertStartsSoon,
                time: l10n.minutesAgo7,
                image: AppAssets.ellipse1,
                isHighlighted: true,
              ),
              NotificationCard(
                title: l10n.bookingConfirmed,
                description: l10n.bookingConfirmedDescription,
                time: l10n.oneHourAgo,
                image: AppAssets.ellipse2,
                isHighlighted: true,
              ),
              NotificationCard(
                title: l10n.specialOffer,
                description: l10n.specialOfferDescription,
                time: l10n.sevenHoursAgo,
                image: AppAssets.ellipse3,
              ),
              NotificationCard(
                title: l10n.locationUpdate,
                description: l10n.locationUpdateDescription,
                time: l10n.twelveHoursAgo,
                image: AppAssets.ellipse4,
                isHighlighted: true,
              ),
              NotificationCard(
                title: l10n.eventCancellation,
                description: l10n.eventCancellationDescription,
                time: l10n.oneDayAgo,
                image: AppAssets.ellipse2,
              ),
              NotificationCard(
                title: l10n.newEventAvailable,
                description: l10n.newEventAvailableDescription,
                time: l10n.twoDaysAgo,
                image: AppAssets.ellipse3,
                isHighlighted: true,
              ),
              NotificationCard(
                title: l10n.eventReminder,
                description: l10n.eventReminderDescription,
                time: l10n.threeDaysAgo,
                image: AppAssets.ellipse4,
              ),
              NotificationCard(
                title: l10n.ticketExpiringSoon,
                description: l10n.ticketExpiringSoonDescription,
                time: l10n.fourDaysAgo,
                image: AppAssets.ellipse2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
