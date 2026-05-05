import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/custom_back_button.dart';
import 'package:event_hub/features/widgets/notification_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // 🔥 الجديد

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<NotificationProvider>().fetchNotifications();
    });
  }

  // 🔥 format time
  String formatTime(String? time) {
    if (time == null || time.isEmpty) return "";

    try {
      final date = DateTime.parse(time);
      return DateFormat('dd MMM, hh:mm a').format(date);
    } catch (_) {
      return time;
    }
  }

  // 🔥 Skeleton Widget جوه نفس الملف
  Widget buildSkeleton() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Row(
              children: [
                // circle image
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),

                // text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: 150,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = context.watch<NotificationProvider>();

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        leading: CustomBackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
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
            Expanded(
              child: provider.isLoading
                  ? buildSkeleton() // 🔥 بدل spinner

                  : provider.notifications.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_off,
                                size: 60,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "No Notifications Yet",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: provider.notifications.length,
                          itemBuilder: (context, index) {
                            final n = provider.notifications[index];

                            return NotificationCard(
                              title: n.title,
                              description: n.body,
                              time: formatTime(n.time),
                              image: n.image ?? AppAssets.ellipse1,
                              isHighlighted: false,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
