import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filterbutton extends StatelessWidget {
  const Filterbutton({super.key});

  void _tapSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _buildBottomSheetContent(context),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 25,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                AppLocalizations.of(context)!.refineEvents,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Choose the best way to explore events",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),
              _buildLuxuryOption(
                context,
                icon: Icons.auto_awesome_rounded,
                title: AppLocalizations.of(context)!.combiningTheTwo,
                subtitle: AppLocalizations.of(context)!
                    .earliestdateswiththelowestprices,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffFF9F43),
                    Color(0xffFF6B00),
                  ],
                ),
                onTap: () {
                  context.read<EventProvider>().sortBySmartChoice();
                  Navigator.pop(context);
                },
              ),
              _buildLuxuryOption(
                context,
                icon: Icons.calendar_month_rounded,
                title: AppLocalizations.of(context)!.earliestdates,
                subtitle:
                    AppLocalizations.of(context)!.seeEventshappeningsoonest,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff6C63FF),
                    Color(0xff5A54D1),
                  ],
                ),
                onTap: () {
                  context.read<EventProvider>().sortByDate();
                  Navigator.pop(context);
                },
              ),
              _buildLuxuryOption(
                context,
                icon: Icons.attach_money_rounded,
                title: AppLocalizations.of(context)!.lowestprices,
                subtitle: AppLocalizations.of(context)!
                    .sortbypricefromlowesttohighest,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff00B894),
                    Color(0xff009970),
                  ],
                ),
                onTap: () {
                  context.read<EventProvider>().sortByPriceLowToHigh();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  context.read<EventProvider>().resetSort();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.secondary,
                ),
                label: Text(
                  AppLocalizations.of(context)!.resetToDefault,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuxuryOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(8),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _tapSheet(context),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.tune_rounded,
              color: AppColors.black,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
