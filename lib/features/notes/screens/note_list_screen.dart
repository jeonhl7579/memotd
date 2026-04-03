import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteListScreen extends ConsumerWidget {
  const NoteListScreen({super.key});

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
              '메모',
              style: theme.textTheme.headlineSmall,
            ),
          ),
          const SliverFillRemaining(
            child: Center(
              child: _EmptyNoteState(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}

class _EmptyNoteState extends ConsumerWidget {
  const _EmptyNoteState();

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
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            Icons.sticky_note_2_outlined,
            size: 36,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '아직 메모가 없어요',
          style: theme.textTheme.titleMedium?.copyWith(
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '+ 버튼을 눌러 첫 메모를 작성해 보세요',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
