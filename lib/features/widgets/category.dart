
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  final List<Map<String, String>> _categories = const [
    {"image": "assets/icon/all.svg", "name": "all"},
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
      case 'all':
        return "All";
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

  String _getRawName(String key) {
    switch (key) {
      case 'gaming':
        return 'Gaming';
      case 'tech':
        return 'Tech';
      case 'business':
        return 'Business';
      case 'education':
        return 'Education';
      case 'arts':
        return 'Arts';
      case 'sports':
        return 'Sports';
      case 'fashion':
        return 'Fashion';
      default:
        return 'All';
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.categories,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 105,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final rawName = _getRawName(category["name"]!);
              bool isSelected = eventProvider.selectedCategory == rawName;

              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    eventProvider.setCategory(rawName);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.orange
                              : AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.05),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Center(
                          child:
                              (category["name"] == "all" &&
                                  category["image"] == "")
                              ? Icon(
                                  Icons.grid_view_rounded,
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.grey,
                                )
                              : SvgPicture.asset(category["image"]!, width: 30),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getCategoryName(context, category["name"]!),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected
                              ? AppColors.orange
                              : AppColors.black,
                        ),
                      ),
                    ],
                  ),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
