import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/providers/note_edit/note_edit_provider.dart';
import 'package:memotd/theme/app_colors.dart';
import 'package:memotd/utils/note_date.dart';
import 'package:memotd/utils/sizes.dart';

class NoteEditScreen extends ConsumerStatefulWidget {
  final NoteModel note;
  const NoteEditScreen({super.key, required this.note});

  @override
  ConsumerState<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends ConsumerState<NoteEditScreen> {
  late final QuillController _quillController;
  late final TextEditingController _titleController;
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _quillController = _buildQuillController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _quillController.addListener(_onContentChanged);
    });
  }

  QuillController _buildQuillController() {
    final raw = widget.note.content;
    if (raw != null && raw.isNotEmpty) {
      try {
        return QuillController(
          document: Document.fromJson(jsonDecode(raw)),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (_) {}
    }
    return QuillController.basic();
  }

  void _onContentChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 3), _autoSave);
  }

  void _onTitleChanged(String value) {
    ref.read(noteEditProvider(widget.note).notifier).setTitle(value);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 3), _autoSave);
  }

  Future<void> _autoSave() async {
    if (!mounted) return;
    try {
      final deltaJson = jsonEncode(
        _quillController.document.toDelta().toJson(),
      );
      ref.read(noteEditProvider(widget.note).notifier).setContent(deltaJson);
      await ref.read(noteEditProvider(widget.note).notifier).saveNote();
    } catch (_) {}
  }

  Future<void> _onDone() async {
    _debounceTimer?.cancel();
    await _autoSave();
    if (mounted) {
      final updatedNote = ref.read(noteEditProvider(widget.note)).updatedNote;
      context.pop(updatedNote);
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _quillController.removeListener(_onContentChanged);
    _quillController.dispose();
    _titleController.dispose();
    _editorFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteEditProvider(widget.note));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _TopAppBar(
                  isSaving: state.isSaving,
                  isSaved: state.isSaved,
                  onBack: () => context.pop(),
                  onDone: _onDone,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 128),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TitleField(
                          controller: _titleController,
                          onChanged: _onTitleChanged,
                          isDark: isDark,
                        ),
                        Gaps.v24,
                        _MetadataRow(note: widget.note),
                        const SizedBox(height: 40),
                        QuillEditor(
                          controller: _quillController,
                          focusNode: _editorFocusNode,
                          scrollController: _scrollController,
                          config: const QuillEditorConfig(
                            padding: EdgeInsets.zero,
                            scrollable: false,
                            expands: false,
                            autoFocus: false,
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _FormattingToolbar(controller: _quillController),
          ),
        ],
      ),
    );
  }
}

// ── Top App Bar ────────────────────────────────────────────────────────────────

class _TopAppBar extends StatelessWidget {
  final bool isSaving;
  final bool isSaved;
  final VoidCallback onBack;
  final VoidCallback onDone;

  const _TopAppBar({
    required this.isSaving,
    required this.isSaved,
    required this.onBack,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String? statusText = isSaving
        ? 'SAVING...'
        : (isSaved ? 'SAVED' : null);

    return Container(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Icon(
              Icons.arrow_back,
              size: 16,
              color: isDark ? AppColors.onSurfaceDark : AppColors.onSurface,
            ),
          ),
          Gaps.h16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Edit Memo',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.onSurfaceDark
                        : AppColors.onSurface,
                    height: 1.25,
                  ),
                ),
                if (statusText != null)
                  Text(
                    statusText,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 1.0,
                      height: 1.5,
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDone,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Sizes.radiusFull),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryContainer,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Title Field ────────────────────────────────────────────────────────────────

class _TitleField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final bool isDark;

  const _TitleField({
    required this.controller,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLines: null,
      style: GoogleFonts.manrope(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.onSurfaceDark : AppColors.onSurface,
        height: 1.375,
        letterSpacing: -0.75,
      ),
      decoration: InputDecoration(
        hintText: 'Untitled',
        hintStyle: GoogleFonts.manrope(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: AppColors.hintText,
          height: 1.375,
          letterSpacing: -0.75,
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
    );
  }
}

// ── Metadata Row (Tags + Date) ─────────────────────────────────────────────────

class _MetadataRow extends StatelessWidget {
  final NoteModel note;

  const _MetadataRow({required this.note});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tags = note.tags ?? [];
    final lastEdited = note.updatedAt ?? note.createdAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tags.isNotEmpty)
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.asMap().entries.map((entry) {
              final isSecondary = entry.key.isEven;
              return _TagChip(
                name: entry.value.name,
                bgColor: isSecondary
                    ? AppColors.secondaryContainer
                    : AppColors.tertiaryContainer,
                textColor: isSecondary
                    ? AppColors.onSecondaryContainer
                    : AppColors.onTertiaryContainer,
              );
            }).toList(),
          ),
        Gaps.v8,
        Text(
          'Last edited: ${NoteDate.detailDateFormat(lastEdited)}',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: isDark
                ? AppColors.onSurfaceVariantDark
                : AppColors.onSurfaceVariant,
            height: 1.33,
          ),
        ),
      ],
    );
  }
}

class _TagChip extends StatelessWidget {
  final String name;
  final Color bgColor;
  final Color textColor;

  const _TagChip({
    required this.name,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Sizes.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.label_outline, size: 10, color: textColor),
          const SizedBox(width: 6),
          Text(
            name.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Formatting Toolbar ─────────────────────────────────────────────────────────

class _FormattingToolbar extends StatelessWidget {
  final QuillController controller;

  const _FormattingToolbar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.fromLTRB(34, 16, 34, 16 + bottomInset),
          decoration: BoxDecoration(
            color:
                (isDark ? AppColors.surfaceContainerHighestDark : Colors.white)
                    .withValues(alpha: 0.8),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(color: AppColors.outline.withValues(alpha: 0.15)),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -12),
                blurRadius: 32,
                color: AppColors.shadowTint.withValues(alpha: 0.06),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ToolbarBtn(
                icon: Icons.format_bold,
                onTap: () => controller.formatSelection(Attribute.bold),
              ),
              _ToolbarBtn(
                icon: Icons.format_italic,
                onTap: () => controller.formatSelection(Attribute.italic),
              ),
              _ToolbarBtn(
                icon: Icons.format_list_bulleted,
                onTap: () => controller.formatSelection(Attribute.ul),
              ),
              _ImageToolbarBtn(),
              _ToolbarBtn(icon: Icons.link, onTap: () {}),
              _ToolbarBtn(icon: Icons.more_vert, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolbarBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ToolbarBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 25,
        height: 25,
        child: Icon(
          icon,
          size: 18,
          color: isDark ? AppColors.onSurfaceDark : AppColors.onSurface,
        ),
      ),
    );
  }
}

class _ImageToolbarBtn extends StatelessWidget {
  const _ImageToolbarBtn();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: Icon(
            Icons.image_outlined,
            size: 18,
            color: isDark ? AppColors.onSurfaceDark : AppColors.onSurface,
          ),
        ),
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
