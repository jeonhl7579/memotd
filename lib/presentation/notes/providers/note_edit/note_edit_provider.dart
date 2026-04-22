import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/data/repositories/note_write_repository_impl.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/providers/note_edit/note_edit_state.dart';

final noteEditProvider = NotifierProvider.autoDispose
    .family<NoteEditNotifier, NoteEditState, NoteModel>(NoteEditNotifier.new);

class NoteEditNotifier extends Notifier<NoteEditState> {
  final NoteModel _note;
  NoteEditNotifier(this._note);

  @override
  NoteEditState build() => NoteEditState(
        title: _note.title,
        content: _note.content,
        tags: _note.tags?.map((t) => t.name).toList() ?? [],
      );

  void setTitle(String title) {
    state = state.copyWith(title: title, isSaved: false);
  }

  void setContent(String content) {
    state = state.copyWith(content: content, isSaved: false);
  }

  void setTags(List<String> tags) {
    state = state.copyWith(tags: tags, isSaved: false);
  }

  Future<void> saveNote() async {
    if (state.isSaving || _note.id == null) return;
    state = state.copyWith(isSaving: true, isSaved: false);
    try {
      final updated = _note.copyWith(
        title: state.title,
        content: state.content,
        updatedAt: DateTime.now().toLocal(),
      );
      await ref.read(noteWriteRepositoryProvider).updateNote(updated);
      state = state.copyWith(isSaving: false, isSaved: true, updatedNote: updated);
    } catch (_) {
      state = state.copyWith(isSaving: false);
    }
  }
}
