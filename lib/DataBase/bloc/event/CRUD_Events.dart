abstract class CrudEvents {}

class CreateEvent<T> extends CrudEvents {
  final T object;

  CreateEvent({required this.object});
}

class ReadEvent extends CrudEvents {}

class UpdateEvent<T> extends CrudEvents {
  final T object;

  UpdateEvent({required this.object});
}

class DeleteEvent<T> extends CrudEvents {
  final int index;

  DeleteEvent({required this.index});
}
