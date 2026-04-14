import 'package:drift/drift.dart';
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
  Stream<List<NoteModel>> watchNotes({bool isFavorite = false}) {
    return (_db.select(_db.notes)
          ..where((t) => t.isHidden.equals(false)) // ← false로 수정
          ..orderBy([
            (t) => OrderingTerm.desc(t.updatedAt), // 최신 수정순 기본
          ]))
        .watch()
        .map((rows) => rows.map((r) => r.toModel()).toList());
  }
}
