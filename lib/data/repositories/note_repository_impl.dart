import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/core/providers/app_database_provider.dart';
import 'package:memotd/data/mappers/note_mapper.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/domain/repositories/note_repository.dart';

final noteRepositoryProvider = Provider<NoteRepository>(
  (ref) => NoteRepositoryImpl(ref.watch(appDatabaseProvider)),
);

class NoteRepositoryImpl implements NoteRepository {
  const NoteRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<NoteModel>> getNotes() async {
    final rows = await _db.select(_db.notes).get();
    return rows.map((r) => r.toModel()).toList();
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    final row = await (_db.select(_db.notes)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row?.toModel();
  }

  @override
  Future<void> createNote(NoteModel note) async {
    await _db.into(_db.notes).insert(note.toCompanion());
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    await (_db.update(_db.notes)..where((t) => t.id.equals(note.id)))
        .write(note.toCompanion());
  }

  @override
  Future<void> deleteNote(int id) async {
    await (_db.delete(_db.notes)..where((t) => t.id.equals(id))).go();
  }

  @override
  Stream<List<NoteModel>> watchNotes() {
    return _db
        .select(_db.notes)
        .watch()
        .map((rows) => rows.map((r) => r.toModel()).toList());
  }
}
