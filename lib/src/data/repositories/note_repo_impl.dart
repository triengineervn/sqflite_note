import '../../domain/models/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../data_sources/note_data_source.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDataSource dataSource;

  NoteRepositoryImpl(this.dataSource);

  @override
  Future<List<Note>> getAllNotes() async {
    return dataSource.getAllNotes();
  }

  @override
  Future<int> deleteNoteById(int id) async {
    return await dataSource.deleteNoteById(id);
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await dataSource.getNoteById(id);
  }

  @override
  Future<Note> insertNote(Note note) async {
    return await dataSource.insert(note);
  }

  @override
  Future<int> updateNote(Note note) async {
    return await dataSource.updateNote(note);
  }
}
