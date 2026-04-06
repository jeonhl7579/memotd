import 'package:flutter/material.dart';
import 'package:memotd/theme/app_colors.dart';

class TitleTextFormField extends StatelessWidget {
  final TextEditingController titleController;
  final ThemeData theme;
  final ColorScheme cs;

  const TitleTextFormField({
    super.key,
    required this.titleController,
    required this.theme,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        hintText: "Untitled",
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        isDense: true,
        hintStyle: theme.textTheme.headlineLarge?.copyWith(
          color: AppColors.hintText,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: theme.textTheme.headlineLarge?.copyWith(
        color: cs.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
