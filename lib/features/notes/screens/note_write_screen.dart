import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

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
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Column(
          children: [
            Text('메모 작성', style: theme.textTheme.headlineSmall),
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
