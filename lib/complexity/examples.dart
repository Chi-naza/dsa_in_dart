void main() {
  // TIME COMPLEXITIES

  const numbers = [1, 3, 56, 66, 68, 80, 99, 105, 450];
  const names = ["Chinaza", "John", "Ekene", "Adam", "Hosea", "Joseph"];
}

// Constant Time O(1)
void checkFirst(List<String> names) {
  if (names.isNotEmpty) {
    print(names.first);
  } else {
    print('no names');
  }
}

// Linear Time O(n)
void printNames(List<String> names) {
  for (final name in names) {
    print(name);
  }
}

// Quadratic Time O(n^2)
void printMoreNames(List<String> names) {
  for (final _ in names) {
    for (final name in names) {
      print(name);
    }
  }
}

// Logarithmic Time O(log n)
// An algorithm that can repeatedly drop half of the required comparisons will have logarithmic time complexity.

bool badWayToLocate(int value, List<int> list) {
  for (final element in list) {
    if (element == value) return true;
  }
  return false;
}

bool goodWayToLocate(int value, List<int> list) {
  if (list.isEmpty) return false;
  final middleIndex = list.length ~/ 2;
  if (value > list[middleIndex]) {
    for (var i = middleIndex; i < list.length; i++) {
      if (list[i] == value) return true;
    }
  } else {
    for (var i = middleIndex; i >= 0; i--) {
      if (list[i] == value) return true;
    }
  }
  return false;
}
