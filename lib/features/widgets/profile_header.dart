import 'dart:ui';

import 'package:flutter/material.dart';

import '../home/presentation/tabs/edit_profile.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/image/photo_profile.png"),
          ),
          const SizedBox(height:15),

          const Text("Lama Yousef", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("example@gmail.com", style: TextStyle(color: Colors.grey, fontSize: 14)),

          const SizedBox(height: 15),

          OutlinedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                  )
              );
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Edit profile"),
          ),
        ],
      ),
    );
  }
}