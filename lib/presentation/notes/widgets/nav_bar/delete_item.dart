import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/utils/sizes.dart';

class NoteNavBarDeleteItem extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;
  final ThemeData theme;

  const NoteNavBarDeleteItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = theme.colorScheme.error;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(icon, size: 18, color: errorColor),
          Gaps.v4,
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(color: errorColor),
          ),
        ],
      ),
    );
  }
}
