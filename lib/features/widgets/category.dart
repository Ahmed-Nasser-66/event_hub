import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  final List<Map<String, String>> _categories = const [
    {"image": "assets/icon/games.svg", "name": "gaming"},
    {"image": "assets/icon/tech.svg", "name": "tech"},
    {"image": "assets/icon/business.svg", "name": "business"},
    {"image": "assets/icon/education.svg", "name": "education"},
    {"image": "assets/icon/arts.svg", "name": "arts"},
    {"image": "assets/icon/sports.svg", "name": "sports"},
    {"image": "assets/icon/fashion.svg", "name": "fashion"},
  ];

  String _getCategoryName(BuildContext context, String key) {
    final l10n = AppLocalizations.of(context)!;

    switch (key) {
      case 'gaming':
        return l10n.gaming;
      case 'arts':
        return l10n.arts;
      case 'business':
        return l10n.business;
      case 'tech':
        return l10n.tech;
      case 'fashion':
        return l10n.fashion;
      case 'sports':
        return l10n.sports;
      case 'education':
        return l10n.education;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.categories,
              style: const TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.seeAll,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.orange,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.orange,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];

              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.white,
                      child: SvgPicture.asset(category["image"]!, width: 28),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getCategoryName(context, category["name"]!),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.upcomingEvents,
              style: const TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.seeAll,
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
      ],
    );
  }
}
