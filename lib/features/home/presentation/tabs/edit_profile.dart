import 'package:flutter/material.dart';
import '../../../../core/theme/app_color.dart';
import '../../../widgets/CustomProfileField.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9ECEF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.secondary,
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B1B4B),
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage:
                    AssetImage('assets/image/photo_profile.png'),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "Change Picture",
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              const CustomProfileField(
                label: "Full Name",
                hint: "Enter The Name",
                keyboardType: TextInputType.name,
              ),

              const CustomProfileField(
                label: "Email",
                hint: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
              ),

              const CustomProfileField(
                label: "Phone Number",
                hint: "Enter Phone",
                keyboardType: TextInputType.phone,
              ),

              const CustomProfileField(
                label: "Password",
                hint: "Enter Password",
                keyboardType: TextInputType.text,
              ),
              const CustomProfileField(
                label: "Retype Password",
                hint: "Enter Password",
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1B1B4B)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Color(0xFF1B1B4B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
