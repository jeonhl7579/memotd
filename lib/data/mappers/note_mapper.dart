// data/mappers/note_mapper.dart
import 'package:drift/drift.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/domain/models/tag_model.dart';

extension NoteMapper on Note {
  // 태그 없이 변환 (태그는 repository에서 별도 주입)
  NoteModel toModel({List<TagModel> tags = const []}) => NoteModel(
    id: id,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isFavorite: isFavorite,
    isHidden: isHidden,
    tags: tags,
  );
}

extension NoteModelMapper on NoteModel {
  // Domain Model → DB 저장용 Companion
  NotesCompanion toCompanion() => NotesCompanion(
    title: Value(title),
    content: Value(content),
    createdAt: Value(createdAt),
    updatedAt: updatedAt == null ? const Value.absent() : Value(updatedAt!),
    isFavorite: Value(isFavorite),
  );
}
