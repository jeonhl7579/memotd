import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/utils/sizes.dart';

class NoteNavBarCommonItem extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;
  final ThemeData theme;

  const NoteNavBarCommonItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.theme,
  });

  @override
  State<NoteNavBarCommonItem> createState() => _NoteNavBarCommonItemState();
}

class _NoteNavBarCommonItemState extends State<NoteNavBarCommonItem> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.theme.colorScheme.primary;
    final inactiveColor = widget.theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      // 터치했을때만 상태 변경
      // 터치 후 땟을때는 다시 원래대로
      onTapUp: (_) => setState(() => isActive = false),
      onTapDown: (_) => setState(() => isActive = true),
      onTapCancel: () => setState(() => isActive = false),
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            widget.icon,
            size: 18,
            color: isActive ? activeColor : inactiveColor,
          ),
          Gaps.v4,
          Text(
            widget.label,
            style: widget.theme.textTheme.labelSmall?.copyWith(
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
