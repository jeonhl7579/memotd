import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/core/providers/app_database_provider.dart';
import 'package:memotd/data/mappers/note_mapper.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/domain/repositories/note_write_repository.dart';

final noteWriteRepositoryProvider = Provider<NoteWriteRepository>(
  (ref) => NoteWriteRepositoryImpl(ref.watch(appDatabaseProvider)),
);

class NoteWriteRepositoryImpl implements NoteWriteRepository {
  const NoteWriteRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<NoteModel>> getNotes() async {
    final rows = await _db.select(_db.notes).get();
    return rows.map((r) => r.toModel()).toList();
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    final row = await (_db.select(
      _db.notes,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row?.toModel();
  }

  @override
  Future<NoteModel> createNote(NoteModel note) async {
    // insert 함수는 생성된 데이터의 id를 반환
    final id = await _db.into(_db.notes).insert(note.toCompanion());
    return note.copyWith(id: id);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    if (note.id == null) return;
    await (_db.update(
      _db.notes,
    )..where((t) => t.id.equals(note.id!))).write(note.toCompanion());
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
