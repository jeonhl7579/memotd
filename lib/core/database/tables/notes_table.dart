import 'package:drift/drift.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  TextColumn get imgPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isHidden => boolean().withDefault(const Constant(false))();
}
