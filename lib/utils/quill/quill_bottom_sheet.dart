import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
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
      builder: (sheetContext) {
        void applyFormat(Attribute attribute) {
          // 1. 시트 진입 시점에 캡처한 selection 복원
          controller.updateSelection(selection, ChangeSource.local);
          // 2. 스타일 적용 (커서 위치부터 다음 입력에 적용)
          controller.formatSelection(attribute);
          // 3. 시트 닫기
          Navigator.pop(sheetContext);
        }

        void onIncrease() {
          final sizeAttr = controller
              .getSelectionStyle()
              .attributes[Attribute.size.key];
          final current = (sizeAttr?.value as num?)?.toDouble() ?? 16.0;
          final next = (current + 1).clamp(8, 72); // min 8, max 72
          controller.formatSelection(Attribute.fromKeyValue('size', next));
        }

        void onDecrease() {
          final sizeAttr = controller
              .getSelectionStyle()
              .attributes[Attribute.size.key];
          final current = (sizeAttr?.value as num?)?.toDouble() ?? 16.0;
          final next = (current - 1).clamp(8, 72);
          controller.formatSelection(Attribute.fromKeyValue('size', next));
        }

        return QuillFontSheetContent(
          controller: controller,
          onTitleTap: () => applyFormat(Attribute.h1),
          onHeadingTap: () => applyFormat(Attribute.header),
          onBodyTap: () => applyFormat(Attribute.font),
          onLabelTap: () => applyFormat(Attribute.small),
          onBoldTap: () => applyFormat(Attribute.bold),
          onItalicTap: () => applyFormat(Attribute.italic),
          onUnderlineTap: () => applyFormat(Attribute.ul),
          onStrikeTap: () => applyFormat(Attribute.strikeThrough),
          onIncreaseSizeTap: onIncrease,
          onDecreaseSizeTap: onDecrease,
        );
      },
    );
  }
}
