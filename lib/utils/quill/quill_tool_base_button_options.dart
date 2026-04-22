import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:memotd/utils/sizes.dart';

abstract class QuillToolBaseButtonOptions {
  static QuillToolbarBaseButtonOptions base({
    required IconData iconData,
    required ColorScheme scheme,
  }) {
    return QuillToolbarBaseButtonOptions(
      iconData: iconData,
      iconSize: Sizes.s16,
      iconTheme: QuillIconTheme(
        iconButtonSelectedData: IconButtonData(
          // 글자색
          color: scheme.primary,
          // 배경색
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
        iconButtonUnselectedData: IconButtonData(
          color: scheme.onSurfaceVariant,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          ),
        ),
      ),
    );
  }
}
