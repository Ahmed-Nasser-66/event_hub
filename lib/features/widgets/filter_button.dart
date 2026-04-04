import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filterbutton extends StatelessWidget {
  const Filterbutton({super.key});

  void _tapSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // لجعل الحواف دائرية خلف الحاوية
      isScrollControlled: true,
      builder: (_) => _buildBottomSheetContent(context),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16), // شيت "طاير" لشكل أفخم
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // مقبض السحب
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey.withAlpha(77),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 30),

          const Center(
            child: Text(
              "Refine Events",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.secondary,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 35),

          // 1. خيار الترتيب الذكي (التعديل الجديد)
          _buildLuxuryOption(
            context,
            icon: Icons.auto_awesome_rounded, // أيقونة توحي بالذكاء/التميز
            title: "Combining the two",
            subtitle: "Earliest dates with the lowest prices",
            onTap: () {
              context.read<EventProvider>().sortBySmartChoice();
              Navigator.pop(context);
            },
          ),

          // 2. خيار الترتيب بالتاريخ
          _buildLuxuryOption(
            context,
            icon: Icons.calendar_today_rounded,
            title: "Earliest dates",
            subtitle: "See events happening soonest",
            onTap: () {
              context.read<EventProvider>().sortByDate();
              Navigator.pop(context);
            },
          ),

          // 3. خيار الترتيب بالسعر
          _buildLuxuryOption(
            context,
            icon: Icons.confirmation_number_outlined,
            title: "Lowest prices",
            subtitle: "Sort by price from lowest to highest",
            onTap: () {
              context.read<EventProvider>().sortByPriceLowToHigh();
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 15),
          const Divider(color: AppColors.grey, thickness: 0.5),
          const SizedBox(height: 15),

          // زر إعادة الضبط
          Center(
            child: TextButton.icon(
              onPressed: () {
                context.read<EventProvider>().resetSort();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.refresh_rounded,
                  color: AppColors.secondary, size: 20),
              label: const Text(
                "Reset to Default",
                style: TextStyle(
                    color: AppColors.secondary, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildLuxuryOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: AppColors.grey.withAlpha(51), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.orange.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.orange, size: 24),
              ),
              const SizedBox(width: 18),
              Expanded(
                // أضفنا Expanded لضمان عدم حدوث Overflow في النصوص الطويلة
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: Colors.grey.shade400),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withAlpha(30), // قللت الـ Alpha ليكون الظل واقعي أكثر
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () => _tapSheet(context),
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.tune_rounded, color: AppColors.black, size: 22),
            ),
          ),
        ),
      ),
    );
  }
}
