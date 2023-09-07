import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_atoms/flutter_atoms.dart';

class IncrementAction {}

class DecrementAction {}

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
}
