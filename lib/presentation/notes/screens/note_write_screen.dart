import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/presentation/notes/providers/note_write/note_write_provider.dart';
import 'package:memotd/presentation/notes/widgets/save_note_button.dart';
import 'package:memotd/presentation/notes/widgets/tag_added_list_field.dart';
import 'package:memotd/presentation/notes/widgets/title_text_form_field.dart';
import 'package:memotd/shared/widgets/app_dialog.dart';
import 'package:memotd/utils/quill/quil_ime_sync.dart';
import 'package:memotd/utils/quill/quill_tool_base_button_options.dart';
import 'package:memotd/utils/sizes.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteWriteScreen extends ConsumerStatefulWidget {
  const NoteWriteScreen({super.key});

  @override
  ConsumerState<NoteWriteScreen> createState() => _NoteWriteScreenState();
}

class _NoteWriteScreenState extends ConsumerState<NoteWriteScreen> {
  QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();
  late QuillImeSync _quillImeSync;

  @override
  void initState() {
    super.initState();
    _initImeSync();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_onChanged);
    });
  }

  void _initImeSync() {
    _quillImeSync = QuillImeSync(
      controller: _controller,
      onControllerChanged: (newController) {
        setState(() {
          _controller.removeListener(_onChanged);
          _controller = newController;
          _initImeSync();
          _controller.addListener(_onChanged);
        });
      },
    );
  }

  void _onChanged() {
    try {
      _quillImeSync.onDocumentChanged();
      final deltaJson = jsonEncode(_controller.document.toDelta().toJson());
      ref.read(noteWriteProvider.notifier).setContent(deltaJson);
    } catch (e) {
      // 본문 저장 실패
    }
  }

  void _saveNote() async {
    try {
      final result = await ref.read(noteWriteProvider.notifier).saveNote();
      if (result == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.pop();
        });
      }
      // 저장 성공 시 메모 페이지로 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 현재 스택 제거 후 다음 페이지로 이동
        context.pushReplacement('/notes/detail/${result!.id}', extra: result);
      });
    } catch (e, _) {
      // 저장 시도 중 에러 발생 시 에러 메시지 다이얼로그 표시
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await AppDialog.error(
          context: context,
          msg: "메모를 저장하는 중에 문제가 발생했습니다.\n다시 시도해주세요",
          confirmText: "확인",
        );
      });
    }
  }

  void _cancelNote() {
    context.pop();
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _focusNode.dispose();
    _scrollController.dispose();
    _titleController.dispose();
    super.dispose();
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
      body: Stack(
        children: [
          SafeArea(
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
                    onTitleChanged: ref
                        .read(noteWriteProvider.notifier)
                        .setTitle,
                  ),
                  Gaps.v16,
                  // 태그 영역
                  TagAddedListField(
                    tags: viewModel.asData?.value.tags ?? [],
                    onFieldChanged: ref
                        .read(noteWriteProvider.notifier)
                        .setTags,
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
                          config: QuillEditorConfig(
                            padding: EdgeInsets.all(24),
                            enableInteractiveSelection: true,
                            customShortcuts: {
                              const SingleActivator(LogicalKeyboardKey.enter):
                                  EnterListIntent(),
                            },
                            customActions: {
                              EnterListIntent: EnterListAction(_controller),
                            },
                          ),
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
          if (viewModel.asData?.value.isSaving ?? false)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.18),
              ),
              child: Center(
                child: CircularProgressIndicator(color: cs.primary),
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: Sizes.s12,
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                QuillToolbarToggleStyleButton(
                  attribute: Attribute.bold,
                  controller: _controller,
                  baseOptions: QuillToolBaseButtonOptions.base(
                    iconData: Icons.format_bold,
                    scheme: cs,
                  ),
                ),
                QuillToolbarToggleStyleButton(
                  attribute: Attribute.italic,
                  controller: _controller,
                  baseOptions: QuillToolBaseButtonOptions.base(
                    iconData: Icons.format_italic,
                    scheme: cs,
                  ),
                ),
                QuillToolbarToggleStyleButton(
                  attribute: Attribute.ul,
                  controller: _controller,
                  baseOptions: QuillToolBaseButtonOptions.base(
                    iconData: Icons.format_list_bulleted,
                    scheme: cs,
                  ),
                ),
              ],
            ),
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

class EnterListIntent extends Intent {
  const EnterListIntent();
}

// Action 정의
class EnterListAction extends Action<EnterListIntent> {
  EnterListAction(this.controller);
  final QuillController controller;

  @override
  Object? invoke(EnterListIntent intent) {
    final selection = controller.selection;
    final plainText = controller.document.toPlainText();
    final before = plainText.substring(0, selection.baseOffset);
    final lastNewline = before.lastIndexOf('\n');
    final currentLine = before.substring(lastNewline + 1);

    // 현재 줄이 비어있으면 리스트 종료
    if (currentLine.trim().isEmpty) {
      controller.formatSelection(Attribute.clone(Attribute.ul, null));
      return null;
    }

    // 아니면 기본 엔터 동작
    controller.replaceText(
      selection.baseOffset,
      selection.extentOffset - selection.baseOffset,
      '\n',
      TextSelection.collapsed(offset: selection.baseOffset + 1),
    );
    return null;
  }
}
