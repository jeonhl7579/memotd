import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/features/notes/widgets/save_note_button.dart';

class NoteWriteScreen extends StatefulWidget {
  const NoteWriteScreen({super.key});

  @override
  State<NoteWriteScreen> createState() => _NoteWriteScreenState();
}

class _NoteWriteScreenState extends State<NoteWriteScreen> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: noteWriteAppBar(
        cs,
        theme,
        onSavePressed: () {
          // 메모 저장
        },
        onCancelPressed: () {
          // 뒤로가기
          context.pop();
        },
      ),
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            // 타이틀 영역

            // 태그영역
            // 시간영역
            // 메모 영역
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                  decoration: BoxDecoration(
                    color: cs.onPrimary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: QuillEditor(
                    config: QuillEditorConfig(padding: EdgeInsets.all(24)),
                    focusNode: _focusNode,
                    scrollController: _scrollController,
                    controller: _controller,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget noteWriteAppBar(
  ColorScheme cs,
  ThemeData theme, {
  required void Function() onSavePressed,
  required void Function() onCancelPressed,
}) {
  return AppBar(
    leading: Padding(
      padding: EdgeInsets.only(left: 12),
      child: IconButton(
        onPressed: onCancelPressed,
        icon: Icon(Icons.arrow_back),
      ),
    ),
    title: Text("메모 작성"),
    actions: [
      // 저장 버튼
      saveNoteButton(cs: cs, theme: theme, onSavePressed: onSavePressed),
    ],
    actionsPadding: EdgeInsets.only(right: 24),
  );
}
