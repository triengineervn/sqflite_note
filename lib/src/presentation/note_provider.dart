import 'package:flutter/material.dart';

import '../domain/models/note.dart';
import '../domain/usecases/note_usecase.dart';

class NoteProvider with ChangeNotifier {
  final NoteUseCase noteUseCase;

  List<Note> notes = [];

  NoteProvider({required this.noteUseCase});

  Future<void> loadNotes() async {
    notes = await noteUseCase.getAllNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await noteUseCase.insertNote(note);
    notes.add(note);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await noteUseCase.deleteNoteById(id);
    notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await noteUseCase.updateNote(note);
    final index = notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      notes[index] = note;
      notifyListeners();
    }
  }
}
