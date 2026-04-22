import 'package:memotd/domain/models/note_model.dart';

const _undefined = Object();

class NoteEditState {
  const NoteEditState({
    this.title = '',
    this.content,
    this.tags = const [],
    this.isSaving = false,
    this.isSaved = false,
    this.updatedNote,
  });

  final String title;
  final String? content;
  final List<String> tags;
  final bool isSaving;
  final bool isSaved;
  final NoteModel? updatedNote;

  NoteEditState copyWith({
    String? title,
    Object? content = _undefined,
    List<String>? tags,
    bool? isSaving,
    bool? isSaved,
    Object? updatedNote = _undefined,
  }) {
    return NoteEditState(
      title: title ?? this.title,
      content: content == _undefined ? this.content : content as String?,
      tags: tags ?? this.tags,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      updatedNote: updatedNote == _undefined ? this.updatedNote : updatedNote as NoteModel?,
    );
  }
}
