import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart'; 
import 'package:flutter/material.dart';

class NearbyEventCard extends StatelessWidget {
  const NearbyEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/image/party1.png',
                  height: 100,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 5,
                left: 5,
                child: Icon(Icons.favorite, color: AppColors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    locale.music, 
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  locale.eventTitle, 
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 12,
                      color: AppColors.secondary,
                    ),
                    Text(
                      ' ${locale.location}', 
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: AppColors.secondary,
                    ),
                    Text(
                      ' ${locale.dateTime}', 
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    locale.priceLabel, 
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
