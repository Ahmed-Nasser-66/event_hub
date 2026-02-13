import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/core/theme/app_text_styles.dart'; // استيراد الستايلات
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  int currentPage = 0;

  // 1. نقلنا البيانات بره الـ build لتنظيم الكود
  final List<Map<String, String>> pages = [
    {
      "title": "Welcome to EventHub",
      "desc":
          "Discover amazing events around you, book tickets, and create unforgettable memories.",
      "image": AppAssets.hello,
    },
    {
      "title": "Connect with your community",
      "desc":
          "Meet like-minded people, share interests, and grow your professional network at the best events.",
      "image": AppAssets.onboarding,
    },
    {
      "title": "Your Personal Event Planner",
      "desc":
          "Sync events to your device and get real-time reminders. We help you manage your time.",
      "image": AppAssets.events,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      // 2. جعلنا الـ AppBar شفاف عشان ميبقاش فيه خطوط فاصلة
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pages[index]["image"]!, height: 300),
                      const SizedBox(height: 40),
                      // 3. ربطنا العناوين بـ AppTextStyles
                      Text(
                        pages[index]["title"]!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.headingMedium.copyWith(
                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          pages[index]["desc"]!,
                          textAlign: TextAlign.center,
                          // 4. ربطنا الوصف بـ AppTextStyles
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.secondary.withOpacity(0.7),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // 5. تعديل الـ Indicators لاستخدام AppColors
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  // أضفنا Animation بسيط لشكل النقط
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(4),
                  width: currentPage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? AppColors
                              .secondary // اللون الكحلي من الكود بتاعك
                        : AppColors.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "welcome"),
                    child: Text(
                      "Skip",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.black.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => currentPage == pages.length - 1
                        ? Navigator.pushReplacementNamed(context, "welcome")
                        : controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ),
                    child: Text(
                      currentPage == pages.length - 1 ? "Get Started" : "Next",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
