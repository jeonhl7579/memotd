import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/core/providers/app_database_provider.dart';
import 'package:memotd/data/mappers/note_mapper.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/domain/repositories/note_list_repository.dart';

final noteListRepositoryProvider = Provider<NoteListRepository>(
  (ref) => NoteListRepositoryImpl(ref.watch(appDatabaseProvider)),
);

class NoteListRepositoryImpl implements NoteListRepository {
  const NoteListRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<NoteModel>> getNotes() async {
    final rows = await _db.select(_db.notes).get();
    return rows.map((r) => r.toModel()).toList();
  }

  @override
  Future<List<NoteModel>> getFavoriteNotes() async {
    final rows = await (_db.select(
      _db.notes,
    )..where((t) => t.isFavorite.equals(true))).get();
    return rows.map((r) => r.toModel()).toList();
  }
}
