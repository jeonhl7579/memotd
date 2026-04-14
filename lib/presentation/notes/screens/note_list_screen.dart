import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/providers/note_list/note_list_provider.dart';
import 'package:memotd/presentation/notes/widgets/note_grid_view_item.dart';
import 'package:memotd/presentation/notes/widgets/search_field.dart';
import 'package:memotd/presentation/notes/widgets/tag_selected_field.dart';
import 'package:memotd/utils/sizes.dart';

final tags = ["#전체", "#즐겨찾기"];

final isTagSelectedList = [true, false];

class NoteListScreen extends ConsumerWidget {
  const NoteListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredNoteList = ref.watch(filteredNoteListProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return filteredNoteList.when(
      skipLoadingOnReload: true,
      data: (notes) {
        if (notes.isEmpty) {
          return const _EmptyNoteState();
        }
        return _NoteListScreen(notes: notes, theme: theme, cs: cs);
      },
      error: (error, stackTrace) {
        return const Scaffold(body: Center(child: Text('Error')));
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}

class _NoteListScreen extends StatelessWidget {
  final List<NoteModel> notes;
  final ThemeData theme;
  final ColorScheme cs;
  const _NoteListScreen({
    super.key,
    required this.notes,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(title: Text('메모', style: theme.textTheme.headlineSmall)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Gaps.v16,
              NoteSearchField(
                controller: TextEditingController(),
                onChanged: (value) {},
                onSubmitted: (value) {},
              ),
              Gaps.v16,
              // 태그 필드
              TagSelectedField(
                tags: tags,
                isTagSelectedList: isTagSelectedList,
                onTagSelected: (index) {},
                cs: cs,
              ),
              Gaps.v16,
              NoteGridViewItem(color: cs.onPrimary),
            ],
          ),
        ),
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
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
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
          style: theme.textTheme.titleMedium?.copyWith(color: cs.onSurface),
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
