# flutter_atoms

Simple State Management for flutter

## Usage

```dart
import "flutter_atoms/flutter_atoms";

class IncrementAction {}

class DecrementAction {}

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

void main() {
  dispatch(IncrementAction());
  print(counterAtom.value); // outputs 1

  // You can watch for changes in the build method
  // which will cause a rebuild whenever the atom value changes
  counterAtom.watch(context);
}
```