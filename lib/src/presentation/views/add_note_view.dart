import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/note.dart';
import '../note_provider.dart';

class AddNoteView extends StatefulWidget {
  final Note? note;

  const AddNoteView({super.key, this.note});

  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final description = _descriptionController.text;

                if (title.isNotEmpty) {
                  // Create a new Note object
                  final newNote = Note(
                    id: DateTime.now()
                        .millisecondsSinceEpoch, // Unique ID for example
                    title: title,
                    content: description,
                    createdTime: DateTime.now(),
                  );

                  // Add the note to the provider
                  Provider.of<NoteProvider>(context, listen: false)
                      .addNote(newNote);

                  // Go back to the previous screen
                  Navigator.pop(context);
                }
              },
              child: Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
