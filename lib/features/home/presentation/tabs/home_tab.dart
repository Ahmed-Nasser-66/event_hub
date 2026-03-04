import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/home/presentation/tabs/location.dart';
import 'package:event_hub/features/widgets/category.dart';
import 'package:event_hub/features/widgets/filter_button.dart';
import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/features/widgets/search_bar_widget.dart';
import 'package:event_hub/features/widgets/upcoming_event_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // اختصار عشان الكود يبقى أنضف واحنا بننادي الترجمة
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // --- 1. Header (Location + Greeting) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Location(),
                                ),
                              );
                            },
                            icon: SvgPicture.asset(
                              'assets/icon/location.svg',
                              width: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          // تم استبدال النص الثابت بالترجمة (لو مش موجودة في الـ JSON ضيف "hello": "Hello,")
                          '${locale.welcome} Eslam Ahmed',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icon/bell.svg',
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // --- 2. Search + Filter ---
                Row(
                  children: [
                    Expanded(
                      child: Searchbarwidget(controller: SearchController()),
                    ),
                    const SizedBox(width: 10),
                    const Filterbutton(),
                  ],
                ),

                const SizedBox(height: 5),
                const Category(),
                const SizedBox(height: 5),

                // --- 3. Upcoming Events Cards ---
                SizedBox(
                  height: 310,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => const UpcomingEventCard(),
                  ),
                ),

                const SizedBox(height: 5),

                // --- 5. Nearby Events Section ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.nearbyEvents, // استخدام Key من الـ JSON
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        locale.seeAll, // استخدام Key من الـ JSON
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.orange,
                          decorationColor: AppColors.orange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                // القائمة الرأسية (Nearby)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) => const NearbyEventCard(),
                ),

                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
