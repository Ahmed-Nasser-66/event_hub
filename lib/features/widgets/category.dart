import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  static const Map<String, String> _categoryIcons = {
    'all': 'assets/icon/all.svg',
    'gaming': 'assets/icon/games.svg',
    'tech': 'assets/icon/tech.svg',
    'business': 'assets/icon/business.svg',
    'education': 'assets/icon/education.svg',
    'art': 'assets/icon/arts.svg',
    'sport': 'assets/icon/sports.svg',
    'fashion': 'assets/icon/fashion.svg',
  };

  String _getIconForCategory(String slug) {
    return _categoryIcons[slug.toLowerCase()] ?? 'assets/icon/all.svg';
  }

  String _getCategoryName(BuildContext context, String name) {
    final l10n = AppLocalizations.of(context)!;
    switch (name.toLowerCase()) {
      case 'all':
        return "All";
      case 'gaming':
        return l10n.gaming;
      case 'art':
        return l10n.arts;
      case 'business':
        return l10n.business;
      case 'tech':
        return l10n.tech;
      case 'fashion':
        return l10n.fashion;
      case 'sport':
        return l10n.sports;
      case 'education':
        return l10n.education;
      default:
        return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();
    final categories = eventProvider.categories;

    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.categories,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 105,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length + 1,
            itemBuilder: (context, index) {
              final isAll = index == 0;
              final category = isAll ? null : categories[index - 1];
              final categoryId = category?.id;
              final categoryName = category?.name ?? 'Other';
              final categorySlug = category?.slug ?? 'all';

              final isSelected = isAll
                  ? eventProvider.selectedCategoryId == null
                  : eventProvider.selectedCategoryId == categoryId;

              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: GestureDetector(
                  onTap: () {
                    if (isAll) {
                      eventProvider.selectCategory(
                        CategoryItem(id: 0, name: 'All', slug: 'all'),
                      );
                    } else {
                      eventProvider.selectCategory(category!);
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              isSelected ? AppColors.orange : AppColors.white,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            isAll
                                ? _categoryIcons['all']!
                                : _getIconForCategory(categorySlug),
                            width: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isAll ? "All" : _getCategoryName(context, categoryName),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color:
                              isSelected ? AppColors.orange : AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
