import 'package:flutter/material.dart';

import '../DataBase/db_Controller/DB_Controller_Note.dart';
import '../models/Note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  final DBControllerNote _dbControllerNote = DBControllerNote();
  bool loading = false;

  void read() async {
    loading=true;
    notes = await _dbControllerNote.read();
    loading = false;
    notifyListeners();
  }

  Future<bool> create({required Note note}) async {
    int newRowId = await _dbControllerNote.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      notifyListeners();
    }
    return newRowId != 0;
  }

  Future<bool> delete(int index) async {
    bool deleted = await _dbControllerNote.delete(notes[index].id);
    if (deleted) {
      notes.removeAt(index);
      notifyListeners();
    }
    return deleted;
  }

  Future<bool> update(Note note) async {
    bool updated = await _dbControllerNote.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
        notifyListeners();
      }
    }
    return updated;
  }
}
