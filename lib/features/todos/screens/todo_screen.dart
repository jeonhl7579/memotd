import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(title: Text('ToDo', style: theme.textTheme.headlineSmall)),
      body: const Center(child: _EmptyTodoState()),
    );
  }
}

class _EmptyTodoState extends ConsumerWidget {
  const _EmptyTodoState();

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
            Icons.check_circle_outline,
            size: 36,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '오늘의 할 일이 없어요',
          style: theme.textTheme.titleMedium?.copyWith(color: cs.onSurface),
        ),
        const SizedBox(height: 8),
        Text(
          '+ 버튼을 눌러 첫 번째 할 일을 추가해 보세요',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
