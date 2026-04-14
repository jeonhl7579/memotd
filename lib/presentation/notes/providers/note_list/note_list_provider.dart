import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/data/repositories/note_list_repository_impl.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/providers/note_list/note_list_state.dart';

// 1. StreamProvider
final noteListStreamProvider = StreamProvider<List<NoteModel>>((ref) {
  return ref.watch(noteListRepositoryProvider).watchNotes();
});

// 2. NotifierProvider
final noteListStateProvider =
    NotifierProvider.autoDispose<NoteListNotifier, NoteListState>(
      NoteListNotifier.new,
    );

class NoteListNotifier extends Notifier<NoteListState> {
  @override
  NoteListState build() => const NoteListState();

  void setSearchQuery(String? query) {
    state = state.copyWith(
      searchQuery: (query == null || query.isEmpty) ? null : query,
    );
  }

  void setFilter(NoteListFilter filter) {
    state = state.copyWith(filter: filter);
  }
}

// 3. filteredNoteListProvider
final filteredNoteListProvider =
    Provider.autoDispose<AsyncValue<List<NoteModel>>>((ref) {
      final notesAsync = ref.watch(noteListStreamProvider);
      final state = ref.watch(noteListStateProvider);

      return notesAsync.whenData((notes) {
        var result = notes;

        if (state.filter == NoteListFilter.favorite) {
          result = result.where((n) => n.isFavorite).toList();
        }

        final query = state.searchQuery;
        if (query != null && query.isNotEmpty) {
          result = result
              .where(
                (n) =>
                    n.title.contains(query) ||
                    (n.content?.contains(query) ?? false),
              )
              .toList();
        }

        return result;
      });
    });
