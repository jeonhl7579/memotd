import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/shared/widgets/quill/quill_font_icon_button.dart';
import 'package:memotd/theme/app_colors.dart';
import 'package:memotd/utils/sizes.dart';

class QuillFontSheetContent extends StatelessWidget {
  final void Function() onTitleTap;
  final void Function() onHeadingTap;
  final void Function() onBodyTap;
  final void Function() onLabelTap;
  final void Function() onBoldTap;
  final void Function() onItalicTap;
  final void Function() onUnderlineTap;
  final void Function() onStrikeTap;

  const QuillFontSheetContent({
    super.key,
    required this.onTitleTap,
    required this.onHeadingTap,
    required this.onBodyTap,
    required this.onLabelTap,
    required this.onBoldTap,
    required this.onItalicTap,
    required this.onUnderlineTap,
    required this.onStrikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.s20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.s24),
          topRight: Radius.circular(Sizes.s24),
        ),
        boxShadow: [
          // 위로 올라가는 그림자
          BoxShadow(
            offset: Offset(0, -12),
            blurRadius: 32,
            color: AppColors.shadowTint.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title, Heading, Body, Label lines
          QuillFontTypeScaleLine(
            onTitleTap: onTitleTap,
            onHeadingTap: onHeadingTap,
            onBodyTap: onBodyTap,
            onLabelTap: onLabelTap,
          ),
          Gaps.v20,
          // Bold, Italic, UnderLine, Strike lines
          QuillFontFamilyLine(
            onBoldTap: onBoldTap,
            onItalicTap: onItalicTap,
            onUnderlineTap: onUnderlineTap,
            onStrikeTap: onStrikeTap,
          ),
          // font size section
        ],
      ),
    );
  }
}

// Title, Heading, Body, Label lines
class QuillFontTypeScaleLine extends StatelessWidget {
  final void Function() onTitleTap;
  final void Function() onHeadingTap;
  final void Function() onBodyTap;
  final void Function() onLabelTap;
  const QuillFontTypeScaleLine({
    super.key,
    required this.onTitleTap,
    required this.onHeadingTap,
    required this.onBodyTap,
    required this.onLabelTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuillFontIconButton(
          icon: FontAwesomeIcons.bold,
          label: "TITLE",
          onTap: onTitleTap,
        ),
        QuillFontIconButton(
          icon: FontAwesomeIcons.bold,
          label: "HEADING",
          onTap: onHeadingTap,
        ),
        QuillFontIconButton(
          icon: FontAwesomeIcons.bold,
          label: "BODY",
          onTap: onBodyTap,
        ),
        QuillFontIconButton(
          icon: FontAwesomeIcons.bold,
          label: "LABEL",
          onTap: onLabelTap,
        ),
      ],
    );
  }
}

// Font Family Line
class QuillFontFamilyLine extends StatelessWidget {
  final void Function() onBoldTap;
  final void Function() onItalicTap;
  final void Function() onUnderlineTap;
  final void Function() onStrikeTap;
  const QuillFontFamilyLine({
    super.key,
    required this.onBoldTap,
    required this.onItalicTap,
    required this.onUnderlineTap,
    required this.onStrikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        QuillFontIconButton(
          icon: FontAwesomeIcons.bold,
          label: "BOLD",
          onTap: onBoldTap,
        ),
        QuillFontIconButton(
          icon: FontAwesomeIcons.italic,
          label: "ITALIC",
          onTap: onBoldTap,
        ),
        QuillFontIconButton(
          icon: FontAwesomeIcons.underline,
          label: "UNDERLINE",
          onTap: onUnderlineTap,
        ),
        QuillFontIconButton(
          icon: FontAwesomeIcons.strikethrough,
          label: "STRIKE",
          onTap: onStrikeTap,
        ),
      ],
    );
  }
}
