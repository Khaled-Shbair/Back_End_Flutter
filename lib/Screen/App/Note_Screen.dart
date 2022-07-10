import 'package:data_base/Storage/Pref_Controller.dart';
import 'package:data_base/Utils/Helpers.dart';
import 'package:flutter/material.dart';
import '../../DataBase/get/note_get.dart';
import '../../DataBase/models/Note.dart';

//import 'package:provider/provider.dart';
//import '../../DataBase/Providers/note_provider.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers {
  late TextEditingController _titleEditingController;
  late TextEditingController _infoEditingController;

  @override
  void initState() {
    super.initState();
    _titleEditingController = TextEditingController(text: widget.note?.title);
    _infoEditingController = TextEditingController(text: widget.note?.details);
  }

  @override
  void dispose() {
    _titleEditingController.dispose();
    _infoEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Note',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text(
            'Create Note...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'Enter new Note details',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: _titleEditingController,
            decoration: InputDecoration(
              hintText: 'Title',
              prefixIcon: const Icon(Icons.title),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.text,
            controller: _infoEditingController,
            decoration: InputDecoration(
              hintText: 'Info',
              prefixIcon: const Icon(Icons.title),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => performSave(), child: const Text('SAVE')),
        ],
      ),
    );
  }

  Future<void> performSave() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (_titleEditingController.text.isNotEmpty &&
        _infoEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, massage: 'Enter required data', erorr: true);
    return false;
  }

  Future<void> save() async {
    /////////////////////////////////////////////////////////////////
    /*** Provider State Management ***/
    //bool _saved = widget.note == null
    //    ? await Provider.of<NoteProvider>(context, listen: false)
    //        .create(note: note)
    /////////////////////////////////////////////////////////////////
    /*** Get State Management ***/
    bool _save = isCreate()
        ? await NoteGet.to.create(note: note)
        : await NoteGet.to.updateNode(note);
    /////////////////////////////////////////////////////////////////
    String message = _save ? 'Saved successfully' : 'Saved failed';
    showSnackBar(context, massage: message, erorr: !_save);
    isCreate() ? clear() : Navigator.pop(context);
  }

  bool isCreate() => widget.note == null;

  Note get note {
    Note note = Note();
    if (!isCreate()) {
      note.id = widget.note!.id;
    }
    note.title = _titleEditingController.text;
    note.details = _infoEditingController.text;
    note.userId = PrefController().getKey<int>(key: PrefKeys.id.toString())!;
    return note;
  }

  void clear() {
    _titleEditingController.text = '';
    _infoEditingController.text = '';
  }
}
