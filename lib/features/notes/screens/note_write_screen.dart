import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/features/notes/widgets/add_tag_container.dart';
import 'package:memotd/features/notes/widgets/save_note_button.dart';
import 'package:memotd/features/notes/widgets/tag_added_list_field.dart';
import 'package:memotd/features/notes/widgets/tag_container.dart';
import 'package:memotd/features/notes/widgets/title_text_form_field.dart';
import 'package:memotd/utils/sizes.dart';

class NoteWriteScreen extends StatefulWidget {
  const NoteWriteScreen({super.key});

  @override
  State<NoteWriteScreen> createState() => _NoteWriteScreenState();
}

class _NoteWriteScreenState extends State<NoteWriteScreen> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _titleController = TextEditingController();

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
              ),
              Gaps.v16,
              // 태그영역
              // TagContainer(tag: "Tag", color: cs.tertiary),
              // AddTagContainer(
              //   tag: "ADD TAG",
              //   color: cs.onSurfaceVariant,
              //   onTap: () {},
              // ),
              TagAddedListField(tags: [], onFieldChanged: () {}),
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
