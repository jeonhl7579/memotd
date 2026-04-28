import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/shared/widgets/quill/quill_font_sheet_content.dart';

class QuillBottomSheet {
  static Future<void> fontSelect(
    BuildContext context, {
    required QuillController controller,
    required TextSelection selection,
  }) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => QuillFontSheetContent(
        controller: controller,
        onTitleTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.h1);
          context.pop();
        },
        onHeadingTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.header);
          context.pop();
        },
        onBodyTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.font);
          context.pop();
        },
        onLabelTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.small);
          context.pop();
        },
        onBoldTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.bold);
          context.pop();
        },
        onItalicTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.italic);
          context.pop();
        },
        onUnderlineTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.ul);
          context.pop();
        },
        onStrikeTap: () {
          controller.updateSelection(selection, ChangeSource.local);
          controller.formatSelection(Attribute.strikeThrough);
          context.pop();
        },
      ),
    );
  }
}
