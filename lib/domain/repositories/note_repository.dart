import 'package:memotd/domain/models/note_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getNotes();
  Future<NoteModel?> getNoteById(int id);
  Future<NoteModel> createNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(int id);
  Stream<List<NoteModel>> watchNotes();
}
