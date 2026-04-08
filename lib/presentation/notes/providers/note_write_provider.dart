import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/domain/models/tag_model.dart';
import 'package:memotd/presentation/notes/providers/note_write_state.dart';

final noteWriteProvider = NotifierProvider<NoteWriteNotifier, NoteWriteState>(
  NoteWriteNotifier.new,
);

class NoteWriteNotifier extends Notifier<NoteWriteState> {
  @override
  NoteWriteState build() => const NoteWriteState();

  // 임시저장 기능 추가 시 사용할 초기화 함수
  void initScreen({
    String? title,
    String? content,
    String? path,
    List<String> tags = const [],
  }) {
    state = NoteWriteState(
      title: title ?? '',
      content: content,
      imgPath: path,
      tags: const [], // TODO: NoteRepository 생성 후 tag 이름 → TagModel 변환 추가
      isSaving: false,
    );
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void setImgPath(String? path) {
    state = state.copyWith(imgPath: path);
  }

  void addTag(TagModel tag) {
    if (state.tags.length >= 5) return;
    state = state.copyWith(tags: [...state.tags, tag]);
  }

  void removeTag(int tagId) {
    state = state.copyWith(
      tags: state.tags.where((t) => t.id != tagId).toList(),
    );
  }

  Future<void> saveNote() async {
    if (state.isSaving) return;
    state = state.copyWith(isSaving: true);
    try {
      // TODO: NoteRepository 생성 후 저장 로직 추가
    } catch (e, st) {
      state = state.copyWith(isSaving: false);
      Error.throwWithStackTrace(e, st);
    }
    state = state.copyWith(isSaving: false);
  }
}
