import 'package:flutter/material.dart';

import '../../utils/constant/color.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final bool? isSeeAll;
  final VoidCallback? onTap;

  const TitleRow({
    super.key,
    required this.title,
    this.isSeeAll = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        if (isSeeAll ?? false)
          TextButton(
            onPressed: onTap,
            child: Text(
              'See All',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.red),
            ),
          ),
      ],
    );
  }
}
