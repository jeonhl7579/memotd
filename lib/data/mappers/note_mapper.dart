// data/mappers/note_mapper.dart
import 'package:drift/drift.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/domain/models/note_model.dart';

extension NoteMapper on Note {
  // DB Row → Domain Model
  NoteModel toModel() => NoteModel(
    id: id,
    title: title,
    content: content,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}

extension NoteModelMapper on NoteModel {
  // Domain Model → DB 저장용 Companion
  NotesCompanion toCompanion() => NotesCompanion(
    title: Value(title),
    content: Value(content),
    createdAt: Value(createdAt),
    updatedAt: Value(updatedAt),
  );
}
