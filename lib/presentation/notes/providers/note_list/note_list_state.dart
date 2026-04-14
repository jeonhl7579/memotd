import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_list_state.freezed.dart';

enum NoteListFilter { all, favorite }

@freezed
abstract class NoteListState with _$NoteListState {
  const factory NoteListState({
    String? searchQuery,
    @Default(NoteListFilter.all) NoteListFilter filter,
  }) = _NoteListState;
}
