import '../models/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<Note?> getNoteById(int id);
  Future<Note?> insertNote(Note note);
  Future<int> updateNote(Note note);
  Future<int> deleteNoteById(int id);
}
