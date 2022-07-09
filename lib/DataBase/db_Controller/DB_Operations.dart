abstract class DBOperation<T> {
  Future<int> create(T t);

  Future<List<T>> read();

  Future<T?> show(int id);

  Future<bool> update(T t);

  Future<bool> delete(int id);
}
