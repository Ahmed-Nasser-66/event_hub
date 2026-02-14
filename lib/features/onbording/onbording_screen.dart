import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  int currentPage = 0;

  List<Map<String, String>> pages = [
    {
      "title": "Welcome to EventHub",
      "desc":
          '''Discover amazing events around you, book tickets, and create unforgettable memories.''',
      "image": AppAssets.hello,
    },
    {
      "title": "Connect with your community",
      "desc":
          '''Meet like-minded people, share interests, and grow your professional network at the best events.''',
      "image": AppAssets.onboarding,
    },
    {
      "title": "Your Personal Event Planner ",
      "desc":
          '''Sync events to your device and get real-time reminders. We help you manage your time so you can focus on the experience.''',
      "image": AppAssets.events,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        actions: [],
      ),
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
                      Image.asset(pages[index]["image"]!, height: 200),
                      const SizedBox(height: 20),
                      Text(
                        pages[index]["title"]!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,

                          color: AppColors.secondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          pages[index]["desc"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,

                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: currentPage == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color(0xff05063F)
                        : const Color(0xffADB5BD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, "welcome"),
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Color(0xff495057)),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => currentPage == pages.length - 1
                        ? Navigator.pushReplacementNamed(context, "welcome")
                        : controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          ),
                    child: Text(
                      currentPage == pages.length - 1 ? "Get Started" : "Next",
                      style: const TextStyle(color: Color(0xff05063F)),
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
