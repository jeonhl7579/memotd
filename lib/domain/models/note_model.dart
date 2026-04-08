import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    required int id,
    required String title,
    String? content,
    String? imgPath,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isHidden, // 숨김 속성 추가
  }) = _NoteModel;
}
