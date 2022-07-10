import 'package:get/get.dart';

import '../db_Controller/DB_Controller_Note.dart';
import '../models/Note.dart';

class NoteGet extends GetxController {
  RxList<Note> notes = <Note>[].obs;
  final DBControllerNote _dbControllerNote = DBControllerNote();
  RxBool loading = false.obs;

  static NoteGet get to => Get.find();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  void read() async {
    loading.value = true;
    notes.value = await _dbControllerNote.read();
    loading.value = false;
    //notifyListeners();
    // update();
  }

  Future<bool> create({required Note note}) async {
    int newRowId = await _dbControllerNote.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      //notifyListeners();
      // update();
    }
    return newRowId != 0;
  }

  Future<bool> delete(int index) async {
    bool deleted = await _dbControllerNote.delete(notes[index].id);
    if (deleted) {
      notes.removeAt(index);
      // notifyListeners();
      //update(['Notes_Screen_read']);
    }
    return deleted;
  }

  Future<bool> updateNode(Note note) async {
    bool updated = await _dbControllerNote.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
        //notifyListeners();
        // update();
      }
    }
    return updated;
  }
}
