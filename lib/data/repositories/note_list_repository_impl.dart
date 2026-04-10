import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/core/providers/app_database_provider.dart';
import 'package:memotd/data/mappers/note_mapper.dart';
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
  Future<List<NoteModel>> getNotes() async {
    final rows = await _db.select(_db.notes).get();
    return rows.map((r) => r.toModel()).toList();
  }

  @override
  Future<List<TagModel>> getTopTags({int limit = 3}) async {
    // note_tags 기준으로 태그 사용 횟수를 집계하여 상위 limit개 반환
    final tagCount = _db.noteTags.tagId.count();
    final query = _db.selectOnly(_db.noteTags)
      ..addColumns([_db.noteTags.tagId, tagCount])
      ..groupBy([_db.noteTags.tagId])
      ..orderBy([OrderingTerm.desc(tagCount)])
      ..limit(limit);

    final rows = await query.get();
    final tagIds = rows.map((r) => r.read(_db.noteTags.tagId)!).toList();

    if (tagIds.isEmpty) return [];

    final tags = await (_db.select(
      _db.tags,
    )..where((t) => t.id.isIn(tagIds))).get();

    // tagIds 순서(사용 횟수 내림차순)에 맞게 정렬
    final tagMap = {for (final t in tags) t.id: t};
    return tagIds
        .map((id) => tagMap[id])
        .whereType<Tag>()
        .map((t) => TagModel(id: t.id, name: t.name))
        .toList();
  }
}
