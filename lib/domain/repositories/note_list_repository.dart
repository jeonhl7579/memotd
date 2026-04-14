import 'package:memotd/domain/models/note_model.dart';

abstract class NoteListRepository {
  Stream<List<NoteModel>> watchNotes({bool isFavorite = false});
}
