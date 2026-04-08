import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/presentation/notes/providers/note_write_provider.dart';
import 'package:memotd/presentation/notes/widgets/save_note_button.dart';
import 'package:memotd/presentation/notes/widgets/tag_added_list_field.dart';
import 'package:memotd/presentation/notes/widgets/title_text_form_field.dart';
import 'package:memotd/utils/sizes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteWriteScreen extends ConsumerStatefulWidget {
  const NoteWriteScreen({super.key});

  @override
  ConsumerState<NoteWriteScreen> createState() => _NoteWriteScreenState();
}

class _NoteWriteScreenState extends ConsumerState<NoteWriteScreen> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(() {
        try {
          final deltaJson = jsonEncode(
            _controller.document.toDelta().toJson(),
          ); // List<dynamic> → String 변환
          ref.read(noteWriteProvider.notifier).setContent(deltaJson);
        } catch (e) {
          // 본문 저장 실패
        }
      });
    });
  }

  void _saveNote() {
    // noteWriteProvider에 저장 로직
    print({
      "title": _titleController.text,
      "content": _controller.document.toDelta(),
      "tags": [],
    });
  }

  void _cancelNote() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(noteWriteProvider);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: noteWriteAppBar(
        cs,
        theme,
        onSavePressed: _saveNote,
        onCancelPressed: _cancelNote,
      ),
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // 타이틀 영역
              Gaps.v16,
              TitleTextFormField(
                titleController: _titleController,
                theme: theme,
                cs: cs,
                onTitleChanged: ref.read(noteWriteProvider.notifier).setTitle,
              ),
              Gaps.v16,
              // 태그 영역
              TagAddedListField(
                tags: viewModel.tags,
                onFieldChanged: ref.read(noteWriteProvider.notifier).setTags,
                // 태그 삭제 기능 추가해야할듯
              ),
              // 메모 영역
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    margin: EdgeInsets.only(top: 24),
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
