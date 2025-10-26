import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';

class SimpleAppBar extends StatelessWidget {
  const SimpleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 20),
          Text(
            'الملف الشخصي',
            style: Styles.textStyle16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            radius: 14,
            child: Image.asset(
              AssetsData.notification,
              width: 16,
              height: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
