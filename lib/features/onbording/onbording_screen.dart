import 'package:event_hub/core/theme/app_assets.dart';
import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> pages = [
      {
        "title": l10n.welcomeMessage,
        "desc": l10n.discoverEventsDescription,
        "image": AppAssets.hello,
      },
      {
        "title": l10n.connectCommunityTitle,
        "desc": l10n.connectCommunityDescription,
        "image": AppAssets.onboarding,
      },
      {
        "title": l10n.personalPlannerTitle,
        "desc": l10n.personalPlannerDescription,
        "image": AppAssets.events,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(backgroundColor: AppColors.grey, elevation: 0),
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
                    child: Text(
                      l10n.skip,
                      style: const TextStyle(color: Color(0xff495057)),
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
                      currentPage == pages.length - 1
                          ? l10n.getStarted
                          : l10n.next,
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
