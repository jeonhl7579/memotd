import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.freezed.dart';

@freezed
abstract class TagModel with _$TagModel {
  const factory TagModel({
    required int id,
    required String name,
    String? color,
  }) = _TagModel;
}
