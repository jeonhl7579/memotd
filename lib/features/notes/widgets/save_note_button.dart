import 'package:flutter/material.dart';

Widget saveNoteButton({
  required ColorScheme cs,
  required ThemeData theme,
  required void Function() onSavePressed,
}) {
  return ElevatedButton(
    onPressed: onSavePressed,
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: cs.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    child: Text(
      "Save",
      style: theme.textTheme.bodyMedium?.copyWith(
        color: cs.onPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
