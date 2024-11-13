import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note_provider.dart';
import 'add_note_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
    // Load notes when the widget is initialized
    Provider.of<NoteProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Notes')),
      body: ListView.builder(
        itemCount: noteProvider.notes.length,
        itemBuilder: (context, index) {
          final note = noteProvider.notes[index];
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(note.title),
                Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNoteView(
                              note: note,
                            ),
                          ),
                        );
                        noteProvider.loadNotes();
                      },
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      child: Icon(Icons.delete),
                      onTap: () {
                        setState(() async {
                          await noteProvider.deleteNote(note.id!);
                          noteProvider.loadNotes();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddNoteView and wait for the result
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteView()),
          );
          // Reload notes after returning from AddNoteView
          noteProvider.loadNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
