import 'package:flutter/material.dart';
import 'package:memotd/presentation/notes/widgets/tag_container.dart';

class TagSelectedField extends StatefulWidget {
  final List<String> tags;
  final List<bool> isTagSelectedList;
  final void Function(int index) onTagSelected;
  final ColorScheme cs;

  const TagSelectedField({
    super.key,
    required this.tags,
    required this.isTagSelectedList,
    required this.onTagSelected,
    required this.cs,
  });

  @override
  State<TagSelectedField> createState() => _TagSelectedFieldState();
}

class _TagSelectedFieldState extends State<TagSelectedField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...widget.tags.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TagContainer(tag: entry.value, color: widget.cs.primary),
              );
            }),
          ],
        ),
      ),
    );
  }
}
