import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/data/repositories/note_write_repository_impl.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/providers/note_detail/note_detail_state.dart';

final noteDetailProvider = NotifierProvider.autoDispose
    .family<NoteDetailNotifier, NoteDetailState, NoteModel>(
      NoteDetailNotifier.new,
    );

class NoteDetailNotifier extends Notifier<NoteDetailState> {
  final NoteModel _note;
  NoteDetailNotifier(this._note);

  @override
  NoteDetailState build() => NoteDetailState(note: _note);

  Future<void> toggleFavorite() async {
    final note = state.note;
    if (note.id == null || state.isLoading) return;

    final optimistic = !note.isFavorite;
    state = state.copyWith(note: note.copyWith(isFavorite: optimistic));

    try {
      await ref
          .read(noteWriteRepositoryProvider)
          .toggleFavorite(note.id!, optimistic);
    } catch (_) {
      state = state.copyWith(note: note);
    }
  }

  Future<void> deleteNote() async {
    final note = state.note;
    if (note.id == null || state.isLoading) return;
    print('deleteNote: $note');

    state = state.copyWith(isLoading: true);
    try {
      await ref.read(noteWriteRepositoryProvider).deleteNote(note.id!);
      state = state.copyWith(isLoading: false, isDeleted: true);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }
}
