import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/data/repositories/note_write_repository_impl.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/providers/note_write/note_write_state.dart';

final noteWriteProvider =
    AsyncNotifierProvider.autoDispose<NoteWriteNotifier, NoteWriteState>(
      NoteWriteNotifier.new,
    );

class NoteWriteNotifier extends AsyncNotifier<NoteWriteState> {
  @override
  Future<NoteWriteState> build() async => const NoteWriteState();

  // 임시저장 기능 추가 시 사용할 초기화 함수
  void initScreen({
    String? title,
    String? content,
    List<String> tags = const [],
  }) {
    state = AsyncValue.data(
      NoteWriteState(
        title: title ?? '',
        content: content,
        tags: [],
        isSaving: false,
      ),
    );
  }

  void setTitle(String title) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(title: title));
  }

  void setContent(String content) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(content: content));
  }

  void setTags(List<String> tags) {
    if (state.value == null) return;
    state = AsyncValue.data(state.value!.copyWith(tags: tags));
  }

  Future<NoteModel?> saveNote() async {
    final currentState = state.asData?.value;
    if (currentState == null || currentState.isSaving) return null;

    state = AsyncValue.data(currentState.copyWith(isSaving: true));
    try {
      final repository = ref.read(noteWriteRepositoryProvider);

      final note = NoteModel(
        title: currentState.title,
        content: currentState.content,
        createdAt: DateTime.now().toLocal(),
      );

      final NoteModel savedNote = await repository.createNote(note);

      return savedNote;
    } catch (e, st) {
      print("저장 실패: $e");
      print("스택 트레이스: $st");
      state = AsyncValue.data(currentState.copyWith(isSaving: false));
      Error.throwWithStackTrace("테스트 에러", StackTrace.current);
    }
  }
}
