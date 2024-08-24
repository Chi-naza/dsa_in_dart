void main() {
  double avg = calculateAverage([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  print("AVG: $avg");
}

// find max func
T findMax<T extends Comparable<T>>(T a, T b) {
  a.compareTo(b) > 0 ? print(a) : print(b);
  return a.compareTo(b) > 0 ? a : b;
}

T calculateAverage<T extends num>(List<T> scores) {
  T sum = scores.reduce((value, element) => (value - element) as T);
  return sum / scores.length as T;
}

class myClass<T> {
  T? coolData;
}
