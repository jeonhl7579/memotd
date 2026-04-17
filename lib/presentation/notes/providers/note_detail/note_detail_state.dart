import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:memotd/domain/models/note_model.dart';

part 'note_detail_state.freezed.dart';

@freezed
abstract class NoteDetailState with _$NoteDetailState {
  const NoteDetailState._();

  const factory NoteDetailState({
    required NoteModel note,
    @Default(false) bool isLoading,
    @Default(false) bool isDeleted,
  }) = _NoteDetailState;

  bool get isFavorite => note.isFavorite;
}
