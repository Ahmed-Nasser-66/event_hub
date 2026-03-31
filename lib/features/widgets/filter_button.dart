import 'package:event_hub/core/theme/app_color.dart';
import 'package:event_hub/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filterbutton extends StatelessWidget {
  const Filterbutton({super.key});

  void _tapSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (_) => _buildBottomSheetContent(context),
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Sort & Filter",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.sort_by_alpha, color: AppColors.orange),
              title: const Text("Price: Low to High"),
              onTap: () {
                context.read<EventProvider>().sortByPriceLowToHigh();
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.refresh, color: AppColors.secondary),
              title: const Text("Reset to Default"),
              onTap: () {
                context.read<EventProvider>().resetSort();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: MaterialButton(
        elevation: 0,
        color: AppColors.white,
        shape: const CircleBorder(),
        onPressed: () => _tapSheet(context),
        child: Transform.translate(
          offset: const Offset(-1, 0),
          child: Center(
            child: const Icon(Icons.tune, size: 22, color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
