import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/domain/models/tag_model.dart';
import 'package:memotd/presentation/notes/providers/note_detail/note_detail_provider.dart';
import 'package:memotd/presentation/notes/widgets/nav_bar/common_item.dart';
import 'package:memotd/presentation/notes/widgets/nav_bar/delete_item.dart';
import 'package:memotd/presentation/notes/widgets/nav_bar/favorite_item.dart';
import 'package:memotd/presentation/notes/widgets/tag_container.dart';
import 'package:memotd/utils/note_date.dart';
import 'package:memotd/utils/sizes.dart';

class NoteDetailScreen extends ConsumerStatefulWidget {
  final NoteModel note;
  const NoteDetailScreen({super.key, required this.note});

  @override
  ConsumerState<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends ConsumerState<NoteDetailScreen> {
  late QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = _buildController(widget.note.content);
  }

  QuillController _buildController(String? content) {
    return QuillController(
      document: content != null && content.isNotEmpty
          ? Document.fromJson(jsonDecode(content))
          : Document(),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(noteDetailProvider(widget.note));
    final notifier = ref.read(noteDetailProvider(widget.note).notifier);

    ref.listen(noteDetailProvider(widget.note), (prev, next) {
      if (next.isDeleted) context.pop();
      if (prev != null && prev.note.content != next.note.content) {
        final old = _controller;
        setState(() {
          _controller = _buildController(next.note.content);
        });
        old.dispose();
      }
    });

    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    final note = state.note;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back, size: 24),
        ),
      ),
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v16,
              // 태그 영역
              if (note.tags != null && note.tags!.isNotEmpty)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    noteDetailTagSection(note.tags ?? [], theme),
                    Gaps.v16,
                  ],
                ),
              // 제목 영역
              Text(
                note.title,
                style: theme.textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Gaps.v16,
              // 날짜 영역
              noteDetailDateSection(note.updatedAt ?? note.createdAt, theme),
              Gaps.v16,
              QuillEditor(
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                controller: _controller,
                config: QuillEditorConfig(
                  scrollable: false,
                  autoFocus: false,
                  expands: false,
                  showCursor: false,
                ),
              ),
              Gaps.v80,
              Gaps.v40,
            ],
          ),
        ),
      ),
      bottomNavigationBar: _NoteDetailBottomToolBar(
        theme: theme,
        bottomSpace: bottomSpace,
        isFavorite: state.isFavorite,
        onEdit: () async {
          final updatedNote = await context.push<NoteModel>(
            '/notes/edit/${widget.note.id}',
            extra: widget.note,
          );
          if (updatedNote != null && mounted) {
            ref.read(noteDetailProvider(widget.note).notifier).updateNote(updatedNote);
          }
        },
        onShare: () {},
        onFavorite: notifier.toggleFavorite,
        onDelete: notifier.deleteNote,
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class _NoteDetailBottomToolBar extends StatefulWidget {
  final ThemeData theme;
  final double bottomSpace;
  final bool isFavorite;
  final VoidCallback onEdit;
  final VoidCallback onFavorite;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const _NoteDetailBottomToolBar({
    super.key,
    required this.theme,
    required this.bottomSpace,
    required this.isFavorite,
    required this.onEdit,
    required this.onFavorite,
    required this.onShare,
    required this.onDelete,
  });

  @override
  State<_NoteDetailBottomToolBar> createState() =>
      __NoteDetailBottomToolBarState();
}

class __NoteDetailBottomToolBarState extends State<_NoteDetailBottomToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: EdgeInsets.only(
        left: Sizes.s24,
        right: Sizes.s24,
        bottom: widget.bottomSpace + Sizes.s32,
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.s32),
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(Sizes.s32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NoteNavBarCommonItem(
                icon: FontAwesomeIcons.pencil,
                label: '수정',
                onTap: widget.onEdit,
                theme: widget.theme,
              ),
              Gaps.h40,
              NoteNavBarFavoriteItem(
                icon: FontAwesomeIcons.bookmark,
                activeIcon: FontAwesomeIcons.solidBookmark,
                isFavorite: widget.isFavorite,
                label: '즐겨찾기',
                onTap: widget.onFavorite,
                theme: widget.theme,
              ),
              Gaps.h40,
              NoteNavBarCommonItem(
                icon: FontAwesomeIcons.shareNodes,
                label: '공유',
                onTap: widget.onShare,
                theme: widget.theme,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.s16),
            child: VerticalDivider(
              color: widget.theme.colorScheme.onSurface.withValues(alpha: 0.4),
              thickness: 1,
              width: 1,
            ),
          ),
          NoteNavBarDeleteItem(
            icon: FontAwesomeIcons.trashCan,
            label: '삭제',
            onTap: widget.onDelete,
            theme: widget.theme,
          ),
        ],
      ),
    );
  }
}

Widget noteDetailTagSection(List<TagModel> tags, ThemeData theme) {
  return SizedBox(
    height: 25,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return TagContainer(
          tag: tags[index].name,
          color: theme.colorScheme.primary,
        );
      },
      itemCount: tags.length,
    ),
  );
}

Widget noteDetailDateSection(DateTime time, ThemeData theme) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      FaIcon(
        FontAwesomeIcons.calendar,
        size: 14,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      Gaps.h8,
      Text(
        NoteDate.detailDateFormat(time),
        style: theme.textTheme.bodyMedium?.copyWith(height: 1.2),
      ),
    ],
  );
}
