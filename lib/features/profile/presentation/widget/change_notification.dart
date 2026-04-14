import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationSheet extends StatefulWidget {
  const NotificationSheet({super.key});

  @override
  State<NotificationSheet> createState() => _NotificationSheetState();
}

class _NotificationSheetState extends State<NotificationSheet> {
  String selected = "on";

  @override
  void initState() {
    super.initState();

    selected = context.read<NotificationProvider>().status;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.notifications,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RadioGroup<String>(
            groupValue: selected,
            onChanged: (value) {
              setState(() {
                selected = value!;
              });
            },
            child: Column(
              children: [
                buildOption(l10n.on, "on"),
                const SizedBox(height: 10),
                buildOption(l10n.off, "off"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<NotificationProvider>().setNotification(selected);

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              l10n.confirm,
              style: const TextStyle(color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOption(String title, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected == value
              ? AppColors.orange.withValues(alpha: 0.1)
              : AppColors.grey.withValues(alpha: 1),
          border: Border.all(
            color: selected == value
                ? AppColors.orange
                : AppColors.black.withValues(alpha: 0.7),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight:
                    selected == value ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Radio<String>(
              value: value,
              activeColor: AppColors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
