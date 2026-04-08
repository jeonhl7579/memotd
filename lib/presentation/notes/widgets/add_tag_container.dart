import 'package:flutter/material.dart';
import 'package:memotd/theme/app_text_styles.dart';
import 'package:memotd/utils/sizes.dart';

class AddTagContainer extends StatelessWidget {
  String? tag;
  final Color color;
  final VoidCallback onTap;

  AddTagContainer({
    super.key,
    this.tag,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3.5),
        constraints: BoxConstraints(maxWidth: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: color.withValues(alpha: 0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: color, size: 16),
            if (tag != null) Gaps.h4,
            if (tag != null)
              Text(
                tag ?? "",
                style: AppTextStyles.labelSm.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
