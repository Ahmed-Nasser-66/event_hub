import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String image;
  final bool isHighlighted;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.image,
    this.isHighlighted = false,
  });

  
  ImageProvider _getImageProvider(String image) {
    if (image.startsWith('http')) {
      return NetworkImage(image);
    } else {
      return AssetImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.orange.withAlpha(38) : AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor:
                isHighlighted ? AppColors.orange : AppColors.secondary,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: _getImageProvider(image), 
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isHighlighted
                              ? AppColors.orange
                              : AppColors.secondary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.lightGrey,
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
