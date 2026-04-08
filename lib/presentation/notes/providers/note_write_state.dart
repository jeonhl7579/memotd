import 'package:memotd/domain/models/tag_model.dart';

// nullable 필드를 copyWith에서 null로 명시 설정하기 위한 sentinel
const _undefined = Object();

class NoteWriteState {
  const NoteWriteState({
    this.title = '',
    this.content,
    this.imgPath,
    this.tags = const [],
    this.isSaving = false,
  });

  final String title;
  final String? content; // Delta JSON
  final String? imgPath;
  final List<TagModel> tags;
  final bool isSaving;

  NoteWriteState copyWith({
    String? title,
    Object? content = _undefined,
    Object? imgPath = _undefined,
    List<TagModel>? tags,
    bool? isSaving,
  }) {
    return NoteWriteState(
      title: title ?? this.title,
      content: content == _undefined ? this.content : content as String?,
      imgPath: imgPath == _undefined ? this.imgPath : imgPath as String?,
      tags: tags ?? this.tags,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
