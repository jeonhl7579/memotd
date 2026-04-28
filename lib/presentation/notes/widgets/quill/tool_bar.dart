import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/utils/quill/quill_bottom_sheet.dart';
import 'package:memotd/utils/quill/quill_tool_base_button_options.dart';

class QuillToolBar extends StatefulWidget {
  final ColorScheme cs;
  final QuillController controller;
  final void Function() onPressed;
  const QuillToolBar({
    super.key,
    required this.cs,
    required this.controller,
    required this.onPressed,
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
                FocusScope.of(context).unfocus();
                // 폰트 선택 모달 표시
                await QuillBottomSheet.fontSelect(
                  context,
                  controller: widget.controller,
                  selection: selection,
                );
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

            // QuillToolbarToggleStyleButton(
            //   attribute: Attribute.italic,
            //   controller: widget.controller,
            //   baseOptions: QuillToolBaseButtonOptions.base(
            //     iconData: Icons.format_italic,
            //     scheme: widget.cs,
            //   ),
            // ),
            // QuillToolbarToggleStyleButton(
            //   attribute: Attribute.ul,
            //   controller: widget.controller,
            //   baseOptions: QuillToolBaseButtonOptions.base(
            //     iconData: Icons.format_list_bulleted,
            //     scheme: widget.cs,
            //   ),
            // ),
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
