// nullable 필드를 copyWith에서 null로 명시 설정하기 위한 sentinel
const _undefined = Object();

class NoteWriteState {
  const NoteWriteState({
    this.title = '',
    this.content,
    this.tags = const [],
    this.isSaving = false,
  });

  final String title;
  final String? content; // Delta JSON
  final List<String> tags;
  final bool isSaving;

  NoteWriteState copyWith({
    String? title,
    Object? content = _undefined,
    List<String>? tags,
    bool? isSaving,
  }) {
    return NoteWriteState(
      title: title ?? this.title,
      content: content == _undefined ? this.content : content as String?,
      tags: tags ?? this.tags,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
