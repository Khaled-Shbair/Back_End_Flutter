import 'package:data_base/Storage/Pref_Controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/Note.dart';
import '../DB_Controller.dart';
import '../DB_Operations.dart';

class DBControllerNote implements DBOperation<Note> {
  Database database = DBController().dataBase;

  @override
  Future<int> create(Note note) async {
    int newRowId = await database.insert('notes', note.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeletedRows =
        await database.delete('notes', where: 'id = ?', whereArgs: [id]);
    return countOfDeletedRows == 1;
  }

  @override
  Future<List<Note>> read() async {
    List<Map<String, dynamic>> rows =
        await database.query('notes', where: 'user_id = ?', whereArgs: [
      PrefController().getKey<int>(key: prefKeys.id.toString()),
    ]);
    List<Note> note = rows
        .map((Map<String, dynamic> rowMap) => Note.fromMap(rowMap))
        .toList();
    return note;
  }

  @override
  Future<Note?> show(int id) async {
    List<Map<String, dynamic>> rows =
        await database.query('notes', where: 'id = ?', whereArgs: [id]);
    if (rows.isNotEmpty) {
      return Note.fromMap(rows.first);
    }
    return null;
  }

  @override
  Future<bool> update(Note note) async {
    int countOfUpdatedRows = await database
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
    return countOfUpdatedRows == 1;
  }
}
