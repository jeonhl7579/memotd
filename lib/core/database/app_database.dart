import 'package:drift/drift.dart';

import 'connection/connection.dart';
import 'tables/note_tags_table.dart';
import 'tables/notes_table.dart';
import 'tables/tags_table.dart';

part 'app_database.g.dart';

// 1. @DriftDatabase 어노테이션
@DriftDatabase(tables: [Notes, Tags, NoteTags])
class AppDatabase extends _$AppDatabase {
  // 2. private 생성자
  AppDatabase._() : super(_openConnection());

  // 3. 유일한 instance
  static final AppDatabase instance = AppDatabase._();

  // 4. 외부 접근용 getter
  static AppDatabase get db => instance;

  @override
  int get schemaVersion => 1;

  // 6. DB 파일 경로 설정 및 연결
  static QueryExecutor _openConnection() => openConnection();

  // 5. 앱 종료 시 close() → Drift GeneratedDatabase에서 상속
}
