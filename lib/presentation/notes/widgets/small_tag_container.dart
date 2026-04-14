import 'package:flutter/material.dart';
import 'package:memotd/theme/app_text_styles.dart';

class SmallTagContainer extends StatelessWidget {
  final String tag;
  final Color color;
  const SmallTagContainer({super.key, required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      constraints: BoxConstraints(maxWidth: 130),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: color.withValues(alpha: 0.1),
      ),
      child: Text(
        tag,
        style: AppTextStyles.labelSm.copyWith(
          fontSize: 8,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
