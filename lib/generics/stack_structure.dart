void main() {
  Stack<String> myStack = Stack();

  myStack.push("Chinaza");
  myStack.push("Ada");

  print(myStack);

  myStack.pop();

  print(myStack);
}

class Stack<T> {
  final List<T> _stack = [];

  bool canPop() => _stack.isNotEmpty;

  T pop() {
    final T last = _stack.last;
    _stack.removeLast();
    return last;
  }

  void push(T item) {
    _stack.add(item);
  }

  @override
  String toString() {
    return _stack.toString();
  }
}
