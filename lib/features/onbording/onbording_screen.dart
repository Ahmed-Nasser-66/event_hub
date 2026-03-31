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
                  final isLandscape =
                      MediaQuery.of(context).orientation ==
                      Orientation.landscape;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),

                                Image.asset(
                                  pages[index]["image"]!,
                                  height: isLandscape
                                      ? MediaQuery.of(context).size.height * 0.5
                                      : MediaQuery.of(context).size.height *
                                            0.25,
                                  fit: BoxFit.contain,
                                ),

                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    pages[index]["title"]!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
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
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
                        ? AppColors.secondary
                        : AppColors.lightGrey,
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
                      style: const TextStyle(color: AppColors.lightGrey),
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
                      style: const TextStyle(color: AppColors.secondary),
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
