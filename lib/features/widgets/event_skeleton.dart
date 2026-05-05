import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventSkeleton extends StatelessWidget {
  final bool isHorizontal;

  const EventSkeleton({super.key, this.isHorizontal = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isHorizontal ? 300 : null,
      child: ListView.builder(
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,

        // 🔥 الحل الأساسي للمشكلة
        shrinkWrap: !isHorizontal,
        physics: isHorizontal
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),

        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: isHorizontal ? 12 : 0,
              bottom: isHorizontal ? 0 : 12,
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: isHorizontal ? 220 : double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔹 image placeholder
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔹 title
                    Container(
                      height: 12,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // 🔹 subtitle
                    Container(
                      height: 10,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
