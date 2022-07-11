enum ProcessType {
  create,
  update,
  delete,
}

class CrudState {}

class ListReadState<T> extends CrudState {
  final List<T> list;

  ListReadState({required this.list});
}

class ProcessState extends CrudState {
  final String massage;
  final bool state;
  final ProcessType processType;

  ProcessState({
    required this.massage,
    required this.state,
    required this.processType,
  });
}

class DefaultState extends CrudState {}

class LoadingState extends CrudState {}
