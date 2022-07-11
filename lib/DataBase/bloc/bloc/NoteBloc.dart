import 'package:data_base/DataBase/bloc/event/CRUD_Events.dart';
import 'package:data_base/DataBase/bloc/states/CRUD_States.dart';
import 'package:data_base/DataBase/db_Controller/DB_Controller_Note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Note.dart';

class NoteBloc extends Bloc<CrudEvents, CrudState> {
  NoteBloc(super.initialState) {
    on<CreateEvent<Note>>(_createEvent);
    on<ReadEvent>(_readEvent);
    on<DeleteEvent>(_deleteEvent);
  }

  final DBControllerNote _dbControllerNote = DBControllerNote();
  List<Note> _notes = <Note>[];

  void _readEvent(ReadEvent readEvent, Emitter emitter) async {
    emitter(LoadingState());
    _notes = await _dbControllerNote.read();
    emitter(ListReadState<Note>(list: _notes));
  }

  void _createEvent(CreateEvent<Note> event, Emitter emitter) async {
    int newRowId = await _dbControllerNote.create(event.object);
    if (newRowId != 0) {
      event.object.id = newRowId;
      _notes.add(event.object);
      emitter(ListReadState<Note>(list: _notes));
    }
    String massage = newRowId != 0 ? 'Created Successfully' : 'Created Failed';
    emitter(
      ProcessState(
        massage: massage,
        state: newRowId != 0,
        processType: ProcessType.create,
      ),
    );
  }

  void _deleteEvent(DeleteEvent event, Emitter emitter) async {
    bool deleted = await _dbControllerNote.delete(_notes[event.index].id);
    if (deleted) {
      _notes.removeAt(event.index);
      emitter(ListReadState<Note>(list: _notes));
    }
    String massage = deleted ? 'Deleted Successfully' : 'Deleted Failed';
    emitter(ProcessState(
        massage: massage, state: deleted, processType: ProcessType.delete));
  }
}
