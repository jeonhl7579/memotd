import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    int? id,
    required String title,
    String? content,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool isHidden, // 숨김 속성 추가
  }) = _NoteModel;
}
