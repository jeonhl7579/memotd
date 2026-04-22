import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';

class QuillImeSync {
  QuillImeSync({required this.controller, required this.onControllerChanged});

  final QuillController controller;
  // 컨트롤러 재생성 시 외부(setState)에 알려주는 콜백
  final void Function(QuillController newController) onControllerChanged;

  Delta? _previousDelta;

  void onDocumentChanged() {
    final currentDelta = controller.document.toDelta();
    final json = currentDelta.toJson();

    if (_previousDelta != null &&
        _previousDelta!.toJson().toString() == json.toString()) {
      return;
    }

    _previousDelta = currentDelta;

    if (json.length >= 2) {
      final last = json.last;
      final secondLast = json[json.length - 2];

      final isLastPlainNewline =
          last['insert'] == '\n' && last['attributes'] == null;

      final isSecondLastBullet =
          secondLast['insert'] == '\n' &&
          secondLast['attributes'] != null &&
          (secondLast['attributes'] as Map)['list'] == 'bullet';

      if (isLastPlainNewline && isSecondLastBullet) {
        _syncIme();
      }
    }
  }

  void _syncIme() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentDelta = controller.document.toDelta();
      final currentSelection = controller.selection;

      final newController = QuillController(
        document: Document.fromDelta(currentDelta),
        selection: currentSelection,
      );

      onControllerChanged(newController);
    });
  }
}
