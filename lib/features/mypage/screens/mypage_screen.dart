import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MypageScreen extends ConsumerWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: cs.surface,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              '마이페이지',
              style: theme.textTheme.headlineSmall,
            ),
          ),
          const SliverFillRemaining(
            child: Center(
              child: _MypagePlaceholder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MypagePlaceholder extends ConsumerWidget {
  const _MypagePlaceholder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_outline,
            size: 40,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '마이페이지',
          style: theme.textTheme.titleMedium?.copyWith(
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '달성률, 스트릭, 테마 설정이 여기에 표시돼요',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
