void main() {
  final heap = Heap<int>();
  heap.insert(8);
  heap.insert(6);
  heap.insert(5);
  heap.insert(4);
  heap.insert(3);
  heap.insert(2);
  heap.insert(1);
  print(heap);

  // testing insertion of a priority number
  heap.insert(9);
  print(heap);
  heap.remove();
  print(heap);
  heap.removeAt(2);
  print(heap);
  print(heap.indexOf(8));
  print(heap._firstHasHigherPriority(2, 2));

  var newHeap = Heap<int>(elements: [45, 12, 4, 67, 0, 12, 5, 7, 6, 33, 90]);
  print("NEW HEAP: $newHeap");
  newHeap.remove();
  print("NEW HEAP: $newHeap");
  newHeap._swapValues(1, 2);
  print("NEW HEAP: $newHeap");
}

/*
 
  HEAP: this is a tree-based data structure for finding minimum and maximum elements of a collection.
    * A heap is a complete binary tree, also called binary heap.

  Heap Property:
    1. Max heap -  the parent node must be greater than or equal to the value of the children.
    2. Min heap - the parent node must be less than or equal to the value of the children

  * Unlike a binary search tree, it’s not a requirement of the heap property that the left or right child needs to be greater. 
    For that reason, a heap is only a partially sorted tree.

  Shape Property: A heap must be a complete tree
    - Every tree level must be filled except the last level
    - When adding elements to the last level, add it from left to right (left nodes first, then right).

  *Applications of Heap:
    1. Finding minimum and maximum elements
    2. Implementing Heapsort Algorithm
    3. Constructing a Priority Queue
    4. Building Graph Algorithms that use Priority Queue like Dijkstra Algorithm.

  *Even though heap is a binary tree. We will implement it with a List instead of using nodes:
    - The list is formed from a tree with a zero-based index.
  
  *Accessing Heap Items from a Heap-List (where i is the index of the node):
    - Accessing Left Child of a node: 2i + 1
    - Accessing Right Child of a node: 2i + 2
    - Accessing the parent of a particular node: (i - 1) ~/ 2
    NB: the formula above will give you the index of the left child, right child and parent respectively

  
  SPECIAL NOTE:
    Accessing a particular node in an actual binary tree requires traversing the tree from the root, 
    which is an O(log n) operation. That same operation is just O(1) in a random-access data structure such as a list.
    That's why implementing heap with a list is more efficient.
  
  *PRIORITY:
    - For Max Heap: The priority is the largest element which is the first in the list
    - For Min Heap: The priority is the smallest element which is the first in the list

  *SIFTING UP
    This is a procedure for moving a node to a higher level.
      - This is done by checking the parent of the node, if it is higher than the parent, you swap it with the parent.
      - This swapping with the next parent until the value is no longer larger than its parent.
  

  *SIFTING DOWN
    This is sifting up but done in an opposite direction. You start from the root node:
      - And you check the children. If they have higher priority, you swap them with the root (which is the parent node)
      - You continue this until you get to the last level of the tree node



*/

enum Priority { max, min }

class Heap<E extends Comparable<dynamic>> {
  late final List<E> elements;
  final Priority priority;

  Heap({List<E>? elements, this.priority = Priority.max}) {
    this.elements = (elements == null) ? [] : elements;
    _buildHeap();
  }

  void _buildHeap() {
    if (isEmpty) return;
    final start = elements.length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(i);
    }
  }

  bool get isEmpty => elements.isEmpty;
  int get size => elements.length;
  E? get peek => (isEmpty) ? null : elements.first;

  int _leftChildIndex(int parentIndex) => 2 * parentIndex + 1;

  int _rightChildIndex(int parentIndex) => 2 * parentIndex + 2;

  int _parentIndex(int childIndex) => (childIndex - 1) ~/ 2;

  // Checking two values to ascertain priority
  bool _firstHasHigherPriority(E valueA, E valueB) {
    if (priority == Priority.max) {
      return valueA.compareTo(valueB) > 0;
    }
    return valueA.compareTo(valueB) < 0;
  }

  // check two elements from the indices, the one that has a higer priority
  int _higherPriority(int indexA, int indexB) {
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isFirst = _firstHasHigherPriority(valueA, valueB);
    return (isFirst) ? indexA : indexB;
  }

  // swap two elements
  void _swapValues(int indexA, int indexB) {
    final temp = elements[indexA];
    elements[indexA] = elements[indexB];
    elements[indexB] = temp;
  }

  // Inserting into the heap. This needs to balance priorities - sifting up
  void insert(E value) {
    elements.add(value);
    _siftUp(elements.length - 1);
  }

  // SiftUp function
  void _siftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);
    // while the child index is not zero, i.e it is not priority AND the child is a priority compared to it's current parent, THEN, sifting up continues
    while (child > 0 && child == _higherPriority(child, parent)) {
      _swapValues(child, parent);
      child = parent;
      parent = _parentIndex(child);
    }
  }
  // The overall complexity of insert is O(log n). Adding an element to a list takes only O(1) while sifting elements up in a heap takes O(log n).

  // Sift Down function: For Removing an element from the heap
  void _siftDown(int index) {
    var parent = index;

    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);

      var chosen = _higherPriority(left, parent);
      chosen = _higherPriority(right, chosen);

      if (chosen == parent) return;
      _swapValues(parent, chosen);
      parent = chosen;
    }
  }

  // The actual remove function
  E? remove() {
    if (isEmpty) return null;
    // take the top element to the bottom
    _swapValues(0, elements.length - 1);
    // save the element so you can return it. And remove it
    final value = elements.removeLast();
    // sift down
    _siftDown(0);
    return value;
  }

  // The overall complexity of remove is O(log n). Swapping elements in a list is only O(1) while sifting elements down in a heap takes O(log n) time.

  // REMOVE AT A PARTICULAR IN INDEX
  E? removeAt(int index) {
    final lastIndex = elements.length - 1;

    if (index < 0 || index > lastIndex) {
      return null;
    }

    if (index == lastIndex) {
      return elements.removeLast();
    }

    _swapValues(index, lastIndex);
    final value = elements.removeLast();

    _siftDown(index);
    _siftUp(index);
    return value;
  }

// Removing an arbitrary element from a heap is an O(log n) operation. But it needs an index, which is not easy to know on the surface. We then have indexOf()

// Finding Index of A particular Element
  int indexOf(E value, {int index = 0}) {
    if (index >= elements.length) {
      return -1;
    }

    if (_firstHasHigherPriority(value, elements[index])) {
      return -1;
    }

    if (value == elements[index]) {
      return index;
    }

    final left = indexOf(value, index: _leftChildIndex(index));
    if (left != -1) return left;
    return indexOf(value, index: _rightChildIndex(index));
  }

  @override
  String toString() => elements.toString();
}
