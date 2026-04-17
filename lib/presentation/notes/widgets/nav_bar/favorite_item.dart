import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/utils/sizes.dart';

class NoteNavBarFavoriteItem extends StatefulWidget {
  final FaIconData icon;
  final FaIconData activeIcon;
  final bool isFavorite;
  final String label;
  final VoidCallback onTap;
  final ThemeData theme;

  const NoteNavBarFavoriteItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.isFavorite,
    required this.label,
    required this.onTap,
    required this.theme,
  });

  @override
  State<NoteNavBarFavoriteItem> createState() => _NoteNavBarFavoriteItemState();
}

class _NoteNavBarFavoriteItemState extends State<NoteNavBarFavoriteItem> {
  @override
  Widget build(BuildContext context) {
    final activeColor = widget.theme.colorScheme.primary;
    final inactiveColor = widget.theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      // 터치했을때만 상태 변경
      // 터치 후 땟을때는 다시 원래대로
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            widget.isFavorite ? widget.activeIcon : widget.icon,
            size: 18,
            color: widget.isFavorite ? activeColor : inactiveColor,
          ),
          Gaps.v4,
          Text(
            widget.label,
            style: widget.theme.textTheme.labelSmall?.copyWith(
              color: widget.isFavorite ? activeColor : inactiveColor,
            ),
          ),
          if (widget.isFavorite)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gaps.v4,
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activeColor,
                  ),
                  width: 3,
                  height: 3,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
