import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memotd/domain/models/note_model.dart';

part 'note_list_state.freezed.dart';

enum NoteListFilter { all, favorite }

@freezed
abstract class NoteListState with _$NoteListState {
  const factory NoteListState({
    String? searchQuery,
    @Default(NoteListFilter.all) NoteListFilter filter,
    @Default([]) List<NoteModel> noteList,
  }) = _NoteListState;
}
