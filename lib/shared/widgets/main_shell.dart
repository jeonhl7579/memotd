import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'custom_floating_button.dart';

/// 앱 전체를 감싸는 Shell 위젯.
/// StatefulShellRoute.indexedStack 의 builder 에서 주입받는다.
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showFab = navigationShell.currentIndex < 2; // 메모·ToDo 탭에서만 표시

    return Scaffold(
      extendBody: true, // 바텀 네비 영역까지 body 확장 (blur 위해 필요)

      body: navigationShell,
      // FAB 을 bottomNavigationBar 와 같은 Scaffold 에 두면
      // Flutter 가 자동으로 네비바 위에 올바르게 배치한다.
      floatingActionButton: showFab
          ? CustomFloatingButton(onPressed: () {})
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _GlassNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}

// ── Items definition ─────────────────────────────────────────────────────────

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

const _navItems = [
  _NavItem(
    label: '메모',
    icon: Icons.sticky_note_2_outlined,
    activeIcon: Icons.sticky_note_2,
  ),
  _NavItem(
    label: 'ToDo',
    icon: Icons.check_circle_outline_rounded,
    activeIcon: Icons.check_circle_rounded,
  ),
  _NavItem(
    label: '마이페이지',
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
  ),
];

// ── Glassmorphism bottom navigation bar ──────────────────────────────────────

class _GlassNavBar extends ConsumerWidget {
  const _GlassNavBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          // surfaceContainerHighest @ 70% — "Glass & Gradient Rule"
          decoration: BoxDecoration(
            color: cs.onPrimary,
            boxShadow: [
              // 상단으로 약간의 그림자
              BoxShadow(
                color: cs.shadow.withValues(alpha: 1),
                blurRadius: 12,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64 + bottomPadding,
              child: Row(
                children: List.generate(
                  _navItems.length,
                  (i) => Expanded(
                    child: _NavTile(
                      item: _navItems[i],
                      isActive: currentIndex == i,
                      onTap: () => onTap(i),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Individual nav tile with animated dot indicator ──────────────────────────

class _NavTile extends ConsumerWidget {
  const _NavTile({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final iconColor = isActive ? cs.primary : cs.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isActive ? item.activeIcon : item.icon,
              key: ValueKey(isActive),
              size: 24,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 3),
          // Label
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: iconColor,
              letterSpacing: 0.2,
            ),
            child: Text(item.label),
          ),
          const SizedBox(height: 5),
          // Active dot — 4px primary circle (design system spec)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: isActive ? 4 : 0,
            height: isActive ? 4 : 0,
            decoration: BoxDecoration(
              color: cs.primary,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
