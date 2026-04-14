import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/features/widgets/nearby_event_card.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final favoriteProvider = context.watch<FavoriteProvider>();
    final favoriteList = favoriteProvider.favoriteEvents;

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: false,
        title: Text(
          locale.favoriteEvents,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: favoriteList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: AppColors.cardGrey,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      locale.noFavorites,
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.lightGrey,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: favoriteList.length,
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  return NearbyEventCard(event: favoriteList[index]);
                },
              ),
      ),
    );
  }
}
