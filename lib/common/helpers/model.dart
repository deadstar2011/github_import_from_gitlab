const ID = 'id';

T Function(dynamic) getItemParam<T>(String key) => (item) => item[key] as T;

int Function(dynamic) getItemId = getItemParam<int>(ID);

T Function(int) getItem<T>(Map<int, T> data) {
  return (int id) => data[id];
}

