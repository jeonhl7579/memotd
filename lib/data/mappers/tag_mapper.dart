import 'package:memotd/core/database/app_database.dart';
import 'package:memotd/domain/models/tag_model.dart';

extension TagMapper on Tag {
  TagModel toModel() => TagModel(id: id, name: name);
}
