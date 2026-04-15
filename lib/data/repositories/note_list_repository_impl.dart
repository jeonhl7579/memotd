import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/core/providers/app_database_provider.dart';
import 'package:memotd/data/mappers/note_mapper.dart';
import 'package:memotd/data/mappers/tag_mapper.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/domain/models/tag_model.dart';
import 'package:memotd/domain/repositories/note_list_repository.dart';

final noteListRepositoryProvider = Provider<NoteListRepository>(
  (ref) => NoteListRepositoryImpl(ref.watch(appDatabaseProvider)),
);

class NoteListRepositoryImpl implements NoteListRepository {
  const NoteListRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<NoteModel>> watchNotes() {
    // 노트 Stream
    final noteStream =
        (_db.select(_db.notes)
              ..where((t) => t.isHidden.equals(false))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .watch();

    // 노트 변경될 때마다 태그도 함께 조회
    return noteStream.asyncMap((rows) async {
      return Future.wait(
        rows.map((row) async {
          final tags = await _getTagsByNoteId(row.id);
          return row.toModel(tags: tags);
        }),
      );
    });
  }

  // 노트 ID로 태그 목록 조회
  Future<List<TagModel>> _getTagsByNoteId(int noteId) async {
    // note_tags 중간 테이블을 통해 tags 조회
    final query = _db.select(_db.tags).join([
      innerJoin(_db.noteTags, _db.noteTags.tagId.equalsExp(_db.tags.id)),
    ])..where(_db.noteTags.noteId.equals(noteId));

    final result = await query.get();
    return result.map((row) => row.readTable(_db.tags).toModel()).toList();
  }
}
