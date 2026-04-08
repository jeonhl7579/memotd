import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memotd/core/database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>(
  (ref) => AppDatabase.db,
);
