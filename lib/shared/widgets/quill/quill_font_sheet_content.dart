import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/shared/widgets/quill/quill_font_icon_button.dart';
import 'package:memotd/theme/app_colors.dart';
import 'package:memotd/utils/sizes.dart';

class QuillFontSheetContent extends StatefulWidget {
  final QuillController controller;
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
    required this.controller,
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
  State<QuillFontSheetContent> createState() => _QuillFontSheetContentState();
}

class _QuillFontSheetContentState extends State<QuillFontSheetContent> {
  @override
  Widget build(BuildContext context) {
    final style = widget.controller.getSelectionStyle();
    final attrs = style.attributes;
    final isTitle = attrs.containsKey(Attribute.h1);
    final isHeading = attrs.containsKey(Attribute.header);
    final isBody = attrs.containsKey(Attribute.font);
    final isLabel = attrs.containsKey(Attribute.small);
    final isBold = attrs.containsKey(Attribute.bold);
    final isItalic = attrs.containsKey(Attribute.italic);
    final isUnderline = attrs.containsKey(Attribute.ul);
    final isStrike = attrs.containsKey(Attribute.strikeThrough);
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
            isTitle: isTitle,
            isHeading: isHeading,
            isBody: isBody,
            isLabel: isLabel,
            onTitleTap: widget.onTitleTap,
            onHeadingTap: widget.onHeadingTap,
            onBodyTap: widget.onBodyTap,
            onLabelTap: widget.onLabelTap,
          ),
          Gaps.v20,
          // Bold, Italic, UnderLine, Strike lines
          QuillFontFamilyLine(
            isBold: isBold,
            isItalic: isItalic,
            isUnderline: isUnderline,
            isStrike: isStrike,
            onBoldTap: widget.onBoldTap,
            onItalicTap: widget.onItalicTap,
            onUnderlineTap: widget.onUnderlineTap,
            onStrikeTap: widget.onStrikeTap,
          ),
          // font size section
        ],
      ),
    );
  }
}

// Title, Heading, Body, Label lines
class QuillFontTypeScaleLine extends StatelessWidget {
  final bool isTitle;
  final bool isHeading;
  final bool isBody;
  final bool isLabel;
  final void Function() onTitleTap;
  final void Function() onHeadingTap;
  final void Function() onBodyTap;
  final void Function() onLabelTap;
  const QuillFontTypeScaleLine({
    super.key,
    required this.isTitle,
    required this.isHeading,
    required this.isBody,
    required this.isLabel,
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
          isSelected: isTitle,
          icon: FontAwesomeIcons.bold,
          label: "TITLE",
          onTap: onTitleTap,
        ),
        QuillFontIconButton(
          isSelected: isHeading,
          icon: FontAwesomeIcons.heading,
          label: "HEADING",
          onTap: onHeadingTap,
        ),
        QuillFontIconButton(
          isSelected: isBody,
          icon: FontAwesomeIcons.font,
          label: "BODY",
          onTap: onBodyTap,
        ),
        QuillFontIconButton(
          isSelected: isLabel,
          icon: FontAwesomeIcons.tag,
          label: "LABEL",
          onTap: onLabelTap,
        ),
      ],
    );
  }
}

// Font Family Line
class QuillFontFamilyLine extends StatelessWidget {
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;
  final bool isStrike;
  final void Function() onBoldTap;
  final void Function() onItalicTap;
  final void Function() onUnderlineTap;
  final void Function() onStrikeTap;
  const QuillFontFamilyLine({
    super.key,
    required this.isBold,
    required this.isItalic,
    required this.isUnderline,
    required this.isStrike,
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
          isSelected: isBold,
          icon: FontAwesomeIcons.bold,
          label: "BOLD",
          onTap: onBoldTap,
        ),
        QuillFontIconButton(
          isSelected: isItalic,
          icon: FontAwesomeIcons.italic,
          label: "ITALIC",
          onTap: onBoldTap,
        ),
        QuillFontIconButton(
          isSelected: isUnderline,
          icon: FontAwesomeIcons.underline,
          label: "UNDERLINE",
          onTap: onUnderlineTap,
        ),
        QuillFontIconButton(
          isSelected: isStrike,
          icon: FontAwesomeIcons.strikethrough,
          label: "STRIKE",
          onTap: onStrikeTap,
        ),
      ],
    );
  }
}
