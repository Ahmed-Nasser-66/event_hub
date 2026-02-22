import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          'assets/icon/location.svg',
                          width: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('Hello , Eslam Ahmed', style: TextStyle(fontSize: 20)),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icon/bell.svg', width: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
