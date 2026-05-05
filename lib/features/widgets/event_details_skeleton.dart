import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventDetailsSkeleton extends StatelessWidget {
  const EventDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        shimmerBox(height: 16, width: 150),
        const SizedBox(height: 10),
        shimmerBox(height: 12, width: double.infinity),
        const SizedBox(height: 8),
        shimmerBox(height: 12, width: double.infinity),
        const SizedBox(height: 20),
        shimmerBox(height: 16, width: 120),
        const SizedBox(height: 10),
        shimmerBox(height: 80, width: double.infinity),
      ],
    );
  }

  Widget shimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }
}
