import 'package:flutter/material.dart';
import 'package:memotd/theme/app_text_styles.dart';

class TagContainer extends StatelessWidget {
  final String tag;
  final Color color;
  const TagContainer({super.key, required this.tag, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3.5),
      constraints: BoxConstraints(maxWidth: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: color.withValues(alpha: 0.1),
      ),
      child: Text(
        tag,
        style: AppTextStyles.labelSm.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
