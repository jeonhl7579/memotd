import 'package:flutter/material.dart';
import 'package:memotd/shared/widgets/custom_gradient_button.dart';

class AppDialog {
  static Future<void> error({
    required BuildContext context,
    required String msg,
    required String confirmText,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onErrorContainer,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          actionsPadding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          actions: [
            CustomGradientButton(
              text: confirmText,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
