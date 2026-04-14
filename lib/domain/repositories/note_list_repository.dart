import 'package:memotd/domain/models/note_model.dart';

abstract class NoteListRepository {
  Future<List<NoteModel>> getNotes();
  Future<List<NoteModel>> getFavoriteNotes();
}
