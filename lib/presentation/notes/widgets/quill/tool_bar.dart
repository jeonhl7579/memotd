import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/utils/quill/quill_bottom_sheet.dart';
import 'package:memotd/utils/quill/quill_tool_base_button_options.dart';

class QuillToolBar extends StatefulWidget {
  final ColorScheme cs;
  final QuillController controller;
  final void Function() onPressed;
  final FocusNode focusNode;
  // 폰트 시트가 닫힌 직후 호출. IME 강제 동기화 등 후처리에 사용.
  final VoidCallback? onAfterSheet;
  const QuillToolBar({
    super.key,
    required this.cs,
    required this.controller,
    required this.onPressed,
    required this.focusNode,
    this.onAfterSheet,
  });

  @override
  State<QuillToolBar> createState() => _QuillToolBarState();
}

class _QuillToolBarState extends State<QuillToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.cs.onPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        top: 10,
        bottom: MediaQuery.of(context).padding.bottom + 10,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QuillToolbarIconButton(
              icon: FaIcon(FontAwesomeIcons.font),
              onPressed: () async {
                final selection = widget.controller.selection;
                // 폰트 선택 모달 표시 (에디터 포커스 유지)
                await QuillBottomSheet.fontSelect(
                  context,
                  controller: widget.controller,
                  selection: selection,
                );
                if (!mounted) return;
                widget.onAfterSheet?.call();
              },
              isSelected: false,
              iconTheme: QuillIconTheme(
                iconButtonSelectedData: IconButtonData(
                  color: widget.cs.primary,
                ),
                iconButtonUnselectedData: IconButtonData(
                  color: widget.cs.onSurfaceVariant,
                ),
              ),
            ),
            QuillToolbarIconButton(
              icon: FaIcon(FontAwesomeIcons.image),
              onPressed: widget.onPressed,
              isSelected: false,
              iconTheme: QuillIconTheme(
                iconButtonSelectedData: IconButtonData(
                  color: widget.cs.primary,
                ),
                iconButtonUnselectedData: IconButtonData(
                  color: widget.cs.onSurfaceVariant,
                ),
              ),
            ),
            QuillToolbarLinkStyleButton(
              controller: widget.controller,
              baseOptions: QuillToolBaseButtonOptions.base(
                iconData: Icons.link,
                scheme: widget.cs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
