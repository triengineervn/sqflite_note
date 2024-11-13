import '../models/note.dart';
import '../repositories/note_repository.dart';

class NoteUseCase {
  final NoteRepository repository;

  NoteUseCase(this.repository);

  Future<List<Note>> getAllNotes() async {
    return repository.getAllNotes();
  }

  Future<void> insertNote(Note note) async {
    await repository.insertNote(note);
  }

  Future<void> deleteNoteById(int id) async {
    await repository.deleteNoteById(id);
  }

  Future<void> updateNote(Note note) async {
    await repository.updateNote(note);
  }
}
