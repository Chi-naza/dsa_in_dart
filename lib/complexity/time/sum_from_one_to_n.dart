void main() {
  // Using dateTime to check the time complexity of the 2 functions
  final start = DateTime.now();
  final sum = betterSumFromOneTo(20);
  final end = DateTime.now();
  final time = end.difference(start);
  print(sum);
  print(time);
}

// Normal Way
int sumFromOneTo(int n) {
  var sum = 0;
  for (var i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
}

// Better Way
int betterSumFromOneTo(int n) {
  return n * (n + 1) ~/ 2;
}
