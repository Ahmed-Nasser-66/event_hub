

import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:event_hub/model/event_model.dart';
import 'package:event_hub/providers/favorite_provider.dart'; 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    
    final lightGreyColor = AppColors.cardGrey.withOpacity(0.5);

    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Stack(
                  children: [
                    Image.asset(
                      event.imagepath,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.35,
                      fit: BoxFit.cover,
                    ),

                    
                    Positioned(
                      top: 40,
                      left: 20,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.black,
                            size: 25,
                          ),
                        ),
                      ),
                    ),

                    
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Consumer<FavoriteProvider>(
                        builder: (context, favProvider, child) {
                          
                          bool isFav = favProvider.isExist(event);

                          return GestureDetector(
                            onTap: () {
                              favProvider.toggleFavorite(event);
                              
                              
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.white.withOpacity(0.9),
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : AppColors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            event.category.toLowerCase(),
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.black,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              event.location,
                              style: const TextStyle(color: AppColors.black),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.access_time,
                              color: AppColors.black,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              event.datetime,
                              style: const TextStyle(color: AppColors.black),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          locale.aboutEvent,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          locale.eventDetailsDescription,
                          style: const TextStyle(
                            color: AppColors.black,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Speakers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      buildSpeakerCard(
                        "Omar Tarek",
                        "Science",
                        "assets/image/speaker.png",
                      ),
                      const SizedBox(height: 15),
                      buildSpeakerCard(
                        "Majd",
                        "Science",
                        "assets/image/speaker1.png",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Sponsors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        buildSponsorImage("assets/image/sponsors.png"),
                        const SizedBox(width: 15),
                        buildSponsorImage("assets/image/sponsors1.png"),
                        const SizedBox(width: 15),
                        buildSponsorImage("assets/image/sponsors.png"),
                        const SizedBox(width: 15),
                        buildSponsorImage("assets/image/sponsors1.png"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 120), 
              ],
            ),
          ),
        ],
      ),

      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${event.price}", 
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D0E40),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Book Now",
                style: TextStyle(
                  color: Color(0xFF0D0E40),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpeakerCard(String name, String topic, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Speaker Name:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(name, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 5),
              const Text(
                "Topic:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(topic, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSponsorImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white,
        child: Image.asset(
          imagePath,
          width: 70,
          height: 70,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
