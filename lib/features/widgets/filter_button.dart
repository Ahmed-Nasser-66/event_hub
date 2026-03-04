import 'package:event_hub/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class Filterbutton extends StatelessWidget {
  const Filterbutton({super.key});

  // ignore: non_constant_identifier_names
  void _tapSheet(BuildContext Context) {
    showModalBottomSheet(
      context: Context,
      builder: (_) => _buildBottomSheetContent(),
    );
  }

  Widget _buildBottomSheetContent() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 45,
      child: MaterialButton(
        color: AppColors.white,
        shape: const CircleBorder(),
        onPressed: () => _tapSheet(context),

        ///  Transform.translate == > عشان اخلي الايقون في النص
        child: Transform.translate(
          offset: const Offset(-5, 0),
          child: const Icon(Icons.tune),
        ),
      ),
    );
  }
}
