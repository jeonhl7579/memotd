import 'package:flutter/material.dart';
import 'package:memotd/presentation/notes/widgets/add_tag_container.dart';
import 'package:memotd/presentation/notes/widgets/tag_container.dart';

class TagAddedListField extends StatefulWidget {
  final List<String> tags;
  final void Function() onFieldChanged;

  const TagAddedListField({
    super.key,
    required this.tags,
    required this.onFieldChanged,
  });

  @override
  State<TagAddedListField> createState() => _TagAddedListFieldState();
}

class _TagAddedListFieldState extends State<TagAddedListField> {
  bool _isEditing = false;
  bool _needsScroll = false;
  final TextEditingController _tagController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // GlobalKey를 통해 부모가 변경되어도 동일 엘리먼트를 재사용 → 스크롤 포지션 보존
  final GlobalKey _scrollViewKey = GlobalKey();

  Color _tagColor(ColorScheme cs, int index) {
    final colors = [cs.primary, cs.secondary, cs.tertiary];
    return colors[index % colors.length];
  }

  void _startEditing() {
    final needsScroll =
        _scrollController.hasClients &&
        _scrollController.position.maxScrollExtent > 0;
    setState(() {
      _isEditing = true;
      _needsScroll = needsScroll;
    });
    _focusNode.requestFocus();
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      _needsScroll = false;
      _tagController.clear();
    });
  }

  void _submitTag() {
    final text = _tagController.text.trim();
    if (text.isEmpty) {
      _cancelEditing();
      return;
    }

    widget.tags.add(text);
    _tagController.clear();
    widget.onFieldChanged();

    if (_needsScroll) {
      // 편집 모드 유지 채로 새 태그 반영 후 애니메이션,
      // 완료 후 정상 모드 전환 (GlobalKey로 스크롤 포지션 보존)
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) {
          setState(() {
            _isEditing = false;
            _needsScroll = false;
          });
          return;
        }
        _scrollController
            .animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            )
            .then((_) {
              if (mounted) {
                setState(() {
                  _isEditing = false;
                  _needsScroll = false;
                });
              }
            });
      });
    } else {
      setState(() {
        _isEditing = false;
        _needsScroll = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Widget _buildTextField(ColorScheme cs) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 100),
      child: TextField(
        controller: _tagController,
        focusNode: _focusNode,
        onSubmitted: (_) => _submitTag(),
        style: Theme.of(context).textTheme.labelSmall,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 3.5,
          ),
          filled: true,
          fillColor: cs.onSurfaceVariant.withValues(alpha: 0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          suffixIcon: GestureDetector(
            onTap: _cancelEditing,
            child: Icon(Icons.close, size: 16, color: cs.onSurfaceVariant),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 28,
            minHeight: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildScrollView(ColorScheme cs) {
    return SingleChildScrollView(
      key: _scrollViewKey,
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: [
          ...widget.tags.asMap().entries.map((entry) {
            final isLast = entry.key == widget.tags.length - 1;
            // needsScroll 편집 모드에서는 마지막 태그 뒤 gap 없음 (TextField가 외부에 있음)
            final showTrailingGap = !isLast || !(_isEditing && _needsScroll);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TagContainer(tag: entry.value, color: _tagColor(cs, entry.key)),
                if (!isLast) const SizedBox(width: 6),
                if (isLast && showTrailingGap && widget.tags.isNotEmpty)
                  const SizedBox(width: 6),
              ],
            );
          }),
          if (!_isEditing)
            AddTagContainer(color: cs.onSurfaceVariant, onTap: _startEditing),
          if (_isEditing && !_needsScroll) _buildTextField(cs),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tagController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // needsScroll 편집 모드: 스크롤 영역 + 우측 고정 TextField
    if (_isEditing && _needsScroll) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: _buildScrollView(cs)),
          const SizedBox(width: 6),
          _buildTextField(cs),
        ],
      );
    }

    // 기본/비스크롤 편집 모드: 좌측 정렬 스크롤 뷰
    return Align(alignment: Alignment.centerLeft, child: _buildScrollView(cs));
  }
}
