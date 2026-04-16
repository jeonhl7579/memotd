import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/widgets/small_tag_container.dart';
import 'package:memotd/theme/app_colors.dart';
import 'package:memotd/utils/note_date.dart';
import 'package:memotd/utils/sizes.dart';

class NoteGridViewItem extends StatefulWidget {
  final NoteModel note;
  final Color color;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const NoteGridViewItem({
    super.key,
    required this.note,
    required this.color,
    this.createdAt,
    this.updatedAt,
  });

  @override
  State<NoteGridViewItem> createState() => _NoteGridViewItemState();
}

class _NoteGridViewItemState extends State<NoteGridViewItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final doc = (widget.note.content != null && widget.note.content!.isNotEmpty)
        ? quill.Document.fromJson(jsonDecode(widget.note.content!))
        : quill.Document();

    return Container(
      width: 171,
      height: 208,
      padding: EdgeInsets.all(Sizes.s16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.s12),
        color: widget.color,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 24,
            color: AppColors.shadowTint.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      NoteDate.gridDateFormat(
                        widget.note.updatedAt == null
                            ? widget.note.createdAt.toString()
                            : widget.note.updatedAt.toString(),
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Gaps.h4,
                  // 즐겨찾기 버튼으로 변경할 예정
                  FaIcon(
                    FontAwesomeIcons.bookmark,
                    size: 14,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
              Gaps.v8,
              Text(
                widget.note.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
              ),
              Gaps.v4,
              Expanded(
                child: Text(
                  doc.toPlainText(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                ),
              ),
              Gaps.v8,
              // 태그 위치, 하나만 표시
              if (widget.note.tags != null && widget.note.tags!.isNotEmpty)
                SmallTagContainer(
                  tag: "#${widget.note.tags!.first.name}",
                  color: theme.colorScheme.tertiary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
