void main() {
  Stack<String> myNewStack = Stack();
  List lists = [1, 2, 4, 6];

  myNewStack.push("Chi");
  myNewStack.push("Emeka");
  myNewStack.push("Ngozi");
  myNewStack.push("Clinton");

  final anotherStack = Stack.of(lists);

  print(anotherStack);
}

class Stack<E> {
  Stack() : _storage = <E>[];
  final List<E> _storage;
  // push
  void push(E element) => _storage.add(element);

  // pop
  E pop() => _storage.removeLast();

  // converting list of elements to a Stack: using this constructor
  Stack.of(Iterable<E> elements) : _storage = List<E>.of(elements);

  // additional operations
  E get peek => _storage.last;
  bool get isEmpty => _storage.isEmpty;
  bool get isNotEmpty => !isEmpty;

  @override
  String toString() {
    return '--- Top ---\n'
        '${_storage.reversed.join('\n')}'
        '\n-----------';
  }
}
