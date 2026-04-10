import 'package:flutter/material.dart';
import 'package:memotd/theme/app_colors.dart';

class NoteSearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String) onSubmitted;
  const NoteSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: "Search memos..",
        border: noteSearchFieldBorder(),
        focusedBorder: noteSearchFieldBorder(),
        enabledBorder: noteSearchFieldBorder(),
        errorBorder: noteSearchFieldBorder(),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 6),
        prefixIcon: Icon(Icons.search, size: 24, color: AppColors.hintText),

        // prefixIconConstraints: BoxConstraints(minWidth: 24, minHeight: 24),
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.hintText,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

OutlineInputBorder noteSearchFieldBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );
}
