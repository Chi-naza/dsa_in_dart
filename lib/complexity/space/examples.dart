void main() {
  // SPACE COMPLEXITY

  print("Chinaza. " * 3);
}

// Constant Space Complexity: O(1)
// Space remains constant
int multiply(int a, int b) {
  return a * b;
}

// Linear Space Complexity: O(n)
// Space increases with increase in input
List<String> fillList(int length) {
  return List.filled(length, 'a');
}

// Quadratic Space Complexity: O(n^2)
// Space is proportional to the square of the input size
List<String> generateList(int length) {
  return List.filled(length, 'a' * length);
}
