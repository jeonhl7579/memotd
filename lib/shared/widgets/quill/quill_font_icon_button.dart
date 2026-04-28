import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/theme/app_colors.dart';
import 'package:memotd/utils/sizes.dart';

class QuillFontIconButton extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;
  const QuillFontIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Sizes.s52,
        padding: EdgeInsets.symmetric(vertical: Sizes.s2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 컨테이너 + 아이콘 영역
            Container(
              width: Sizes.s48,
              height: Sizes.s48,
              decoration: BoxDecoration(
                color: AppColors.quillButtonBackground,
                borderRadius: BorderRadius.circular(Sizes.s12),
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: Sizes.s16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Gaps.v4,
            // 라벨 영역
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontSize: Sizes.s10),
            ),
          ],
        ),
      ),
    );
  }
}
