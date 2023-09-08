import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_atoms/flutter_atoms.dart';

class IncrementAction {}

class DecrementAction {}

class SetName {}

class FileStorage<T> implements Storage {
  Map<String, T> cache;

  FileStorage({required this.cache});

  @override
  T? get<T>(String key) {
    return cache[key] as T?;
  }

  @override
  Future<void> delete(String key) async {
    cache.remove(key);
  }

  @override
  Future<void> set(String key, value) async {
    cache[key] = value;
  }
}

void main() {
  test('Atom', () {
    final counterAtom = Atom(
      key: "counter",
      initialState: 0,
      reducer: (state, action) {
        if (action is IncrementAction) {
          return state + 1;
        }
        if (action is DecrementAction) {
          return state - 1;
        }
        return state;
      },
    );
    expect(counterAtom.value, 0);
    dispatch(IncrementAction());
    expect(counterAtom.value, 1);
    dispatch(DecrementAction());
    dispatch(DecrementAction());
    expect(counterAtom.value, -1);
    dispatch("");
    expect(counterAtom.value, -1);
  });

  test("Atom with storage", () {
    final storage = FileStorage(cache: {});
    final nameAtom = Atom(
      storage: storage,
      key: "name",
      initialState: "Hello",
      reducer: (state, action) {
        if (action is SetName) {
          return "World";
        }
        return state;
      },
    );
    dispatch(SetName());
    expect(nameAtom.value, "World");
  });

  test("Atom with storage save", () {
    final storage = FileStorage(cache: {"name": "Storage World"});
    final nameAtom = Atom(
      storage: storage,
      key: "name",
      initialState: "Hello",
      reducer: (state, action) {
        if (action is SetName) {
          return "World";
        }
        return state;
      },
    );
    expect(nameAtom.value, "Storage World");
  });
}
