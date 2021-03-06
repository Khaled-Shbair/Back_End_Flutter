/*** Bloc State Management ***/
import 'package:data_base/DataBase/bloc/bloc/NoteBloc.dart';
import 'package:data_base/DataBase/bloc/event/CRUD_Events.dart';
import 'package:data_base/DataBase/bloc/states/CRUD_States.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data_base/Utils/Helpers.dart';
import 'package:flutter/material.dart';
import '../../DataBase/models/Note.dart';
import 'Note_Screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NoteBloc>(context).add(ReadEvent());
  }

/* Collecting Bloc Listener && BlocBuilder */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.create, color: Colors.black),
          ),
        ],
      ),
      body: BlocConsumer<NoteBloc, CrudState>(
        listenWhen: (previous, current) =>
            current is ProcessState &&
            current.processType == ProcessType.delete,
        listener: (context, state) {
          state as ProcessState;
          showSnackBar(context, massage: state.massage, erorr: !state.state);
        },
        buildWhen: (previous, current) =>
            current is ListReadState<Note> || current is LoadingState,
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListReadState && state.list.isEmpty) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NoteScreen(note: state.list[index]),
                      ),
                    );
                  },
                  leading: const Icon(Icons.note),
                  title: Text(state.list[index].title),
                  subtitle: Text(state.list[index].details),
                  trailing: IconButton(
                      onPressed: () {
                        BlocProvider.of<NoteBloc>(context).add(
                          DeleteEvent(index: index),
                        );
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.warning,
                  size: 80,
                ),
                Text(
                  'NO DATA',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.create, color: Colors.black),
          ),
        ],
      ),
      body: BlocListener<NoteBloc, CrudState>(
        listenWhen: (previous, current) =>
            current is ProcessState &&
            current.processType == ProcessType.delete,
        listener: (context, state) {
          state as ProcessState;
          showSnackBar(context, massage: state.massage, erorr: !state.state);
        },
        child: BlocBuilder(
          buildWhen: (previous, current) =>
              current is ListReadState<Note> || current is LoadingState,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ListReadState && state.list.isEmpty) {
              return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteScreen(note: state.list[index]),
                        ),
                      );
                    },
                    leading: const Icon(Icons.note),
                    title: Text(state.list[index].title),
                    subtitle: Text(state.list[index].details),
                    trailing: IconButton(
                        onPressed: () {
                          BlocProvider.of<NoteBloc>(context).add(
                            DeleteEvent(index: index),
                          );
                        },
                        icon: const Icon(Icons.delete)),
                  );
                },
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.warning,
                    size: 80,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
  */
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///*** Get State Management ***///
/*
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:data_base/DataBase/get/note_get.dart';
import 'package:data_base/Utils/Helpers.dart';
import 'package:flutter/material.dart';
import '../../DataBase/models/Note.dart';
import 'Note_Screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers {
  final NoteGet _noteGetController = Get.put(NoteGet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.create, color: Colors.black),
          ),
        ],
      ),
      /********************                 Body                 ********************/
////////////////////////////////////////////////////////////////////////////////
/*
     /*** USE RXList one Controller***/
       body: GetX(
           init: NoteGet(),
           global: true,
           builder: (NoteGet controller) {
             if (controller.loading.isTrue) {
               return const Center(
                 child: CircularProgressIndicator(),
               );
             } else if (controller.notes.isNotEmpty) {
               return ListView.builder(
                 itemCount: controller.notes.length,
                 itemBuilder: (context, index) {
                   return ListTile(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) =>
                               NoteScreen(note: controller.notes[index]),
                         ),
                       );
                     },
                     leading: const Icon(Icons.note),
                     title: Text(controller.notes[index].title),
                     subtitle: Text(controller.notes[index].details),
                     trailing: IconButton(
                         onPressed: () => deleteNote(index),
                         icon: const Icon(Icons.delete)),
                   );
                 },
               );
             } else {
               return Column(
                 mainAxisSize: MainAxisSize.min,
                 children: const [
                   Icon(
                     Icons.warning,
                     size: 80,
                   ),
                   Text(
                     'NO DATA',
                     style: TextStyle(
                       fontSize: 26,
                       fontWeight: FontWeight.bold,
                       color: Colors.black45,
                     ),
                   ),
                 ],
               );
             }
           }),
     );
   */
////////////////////////////////////////////////////////////////////////////////
/*
      /*** USE RXList more than Controller ***/
        body: Obx(
        () {
          if (_noteGetController.loading.isTrue) {
            return const Center(child: CircularProgressIndicator());
          } else if (_noteGetController.notes.isNotEmpty) {
            return ListView.builder(
              itemCount: _noteGetController.notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NoteScreen(note: _noteGetController.notes[index]),
                      ),
                    );
                  },
                  leading: const Icon(Icons.note),
                  title: Text(_noteGetController.notes[index].title),
                  subtitle: Text(_noteGetController.notes[index].details),
                  trailing: IconButton(
                      onPressed: () => deleteNote(index),
                      icon: const Icon(Icons.delete)),
                );
              },
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.warning,
                  size: 80,
                ),
                Text(
                  'NO DATA',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
              ],
            );
          }
        },
      ),
*/
////////////////////////////////////////////////////////////////////////////////
/*
      /*** USE RXList one Controller***/
     body: GetX(
          init: NoteGet(),
          global: true,
          builder: (NoteGet controller) {
            if (controller.loading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.notes.isNotEmpty) {
              return ListView.builder(
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteScreen(note: controller.notes[index]),
                        ),
                      );
                    },
                    leading: const Icon(Icons.note),
                    title: Text(controller.notes[index].title),
                    subtitle: Text(controller.notes[index].details),
                    trailing: IconButton(
                        onPressed: () => deleteNote(index),
                        icon: const Icon(Icons.delete)),
                  );
                },
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.warning,
                    size: 80,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              );
            }
          }
          ),
      */
////////////////////////////////////////////////////////////////////////////////
/*
      body: GetBuilder<NoteGet>(
          init: NoteGet(),
          global: true,
          id: 'Notes_Screen_read',
          builder: (NoteGet controller) {
            if (controller.loading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.notes.isNotEmpty) {
              return ListView.builder(
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NoteScreen(note: controller.notes[index]),
                        ),
                      );
                    },
                    leading: const Icon(Icons.note),
                    title: Text(controller.notes[index].title),
                    subtitle: Text(controller.notes[index].details),
                    trailing: IconButton(
                        onPressed: () => deleteNote(index),
                        icon: const Icon(Icons.delete)),
                  );
                },
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.warning,
                    size: 80,
                  ),
                  Text(
                    'NO DATA',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              );
            }
          }),
*/
////////////////////////////////////////////////////////////////////////////////
    );
  }

  void deleteNote(int index) async {
    bool _deleted = await NoteGet.to.delete(index);
    String message =
        _deleted ? 'Note deleted successfully' : 'Note deleted failed';
    showSnackBar(context, massage: message, erorr: !_deleted);
  }
}
*/
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
///*** Provider State Management ***///
/*
import 'package:data_base/Utils/Helpers.dart';
import 'package:flutter/material.dart';
import '../../DataBase/models/Note.dart';
import 'Note_Screen.dart';
import 'package:provider/provider.dart';
import '../../DataBase/Providers/note_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}
class _NotesScreenState extends State<NotesScreen> with Helpers {

  @override
  void initState() {
    super.initState();
      Provider.of<NoteProvider>(context, listen: false).read();
  }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.create,color: Colors.black),
          ),
        ],
      ),
      body:
          Consumer<NoteProvider>(builder: (context, NoteProvider value, child) {
        if (value.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.notes.isNotEmpty) {
          return ListView.builder(
            itemCount: value.notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NoteScreen(note: value.notes[index]),
                    ),
                  );
                },
                leading: const Icon(Icons.note),
                title: Text(value.notes[index].title),
                subtitle: Text(value.notes[index].details),
                trailing: IconButton(
                    onPressed: () => deleteNote(index),
                    icon: const Icon(Icons.delete)),
              );
            },
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.warning,
                size: 80,
              ),
              Text(
                'NO DATA',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
    void deleteNote(int index) async {
   Provider State Management
     bool _deleted =
         await Provider.of<NoteProvider>(context, listen: false).delete(index);
    String message =
        _deleted ? 'Note deleted successfully' : 'Note deleted failed';
    showSnackBar(context, massage: message, erorr: !_deleted);
  }
}
  */
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
