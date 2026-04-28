import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:memotd/shared/widgets/quill/quill_font_sheet_content.dart';

class QuillBottomSheet {
  static Future<void> fontSelect(
    BuildContext context, {
    required QuillController controller,
  }) {
    return showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => QuillFontSheetContent(
        onTitleTap: () => controller.formatSelection(Attribute.h1),
        onHeadingTap: () => controller.formatSelection(Attribute.header),
        onBodyTap: () => controller.formatSelection(Attribute.font),
        onLabelTap: () => controller.formatSelection(Attribute.small),
        onBoldTap: () => controller.formatSelection(Attribute.bold),
        onItalicTap: () => controller.formatSelection(Attribute.italic),
        onUnderlineTap: () => controller.formatSelection(Attribute.ul),
        onStrikeTap: () => controller.formatSelection(Attribute.strikeThrough),
      ),
    );
  }
}
