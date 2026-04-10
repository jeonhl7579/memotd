import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/domain/models/tag_model.dart';

abstract class NoteListRepository {
  Future<List<NoteModel>> getNotes();
  Future<List<TagModel>> getTopTags({int limit = 3});
}
