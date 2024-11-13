import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/models/note.dart';
import 'note.dart';

class NoteDataSource {
  static final NoteDataSource instance = NoteDataSource._internal();
  factory NoteDataSource() => instance;
  static Database? _database;

// Private constructor
  NoteDataSource._internal();

// Getter for the database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

// Initialize the database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }
  // SQL query to create the database table
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
        CREATE TABLE ${NoteFields.tableName} (
          ${NoteFields.id} ${NoteFields.idType},
          ${NoteFields.number} ${NoteFields.intType},
          ${NoteFields.title} ${NoteFields.textType},
          ${NoteFields.content} ${NoteFields.textType},
          ${NoteFields.isFavorite} ${NoteFields.intType},
          ${NoteFields.createdTime} ${NoteFields.textType}
        )
    ''');
  }


  Future<List<Note>> getAllNotes() async {
    final db = await instance.database;
    const orderBy = '${NoteFields.createdTime} DESC';
    final result = await db.query(NoteFields.tableName, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  // Insert a new note into the database
  Future<Note> insert(Note note) async {
    final db = await instance.database;
    final id = await db.insert(NoteFields.tableName, note.toJson());
    return note.copy(id: id);
  }

// Get a note by its ID
  Future<Note> getNoteById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      NoteFields.tableName,
      columns: [
        NoteFields.id,
        NoteFields.number,
        NoteFields.title,
        NoteFields.content,
        NoteFields.isFavorite,
        NoteFields.createdTime,
      ],
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('Note with ID $id not found');
    }
  }


// Update an existing note
  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    return db.update(
      NoteFields.tableName,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

// Delete a note by its ID
  Future<int> deleteNoteById(int id) async {
    final db = await instance.database;
    return await db.delete(
      NoteFields.tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}




