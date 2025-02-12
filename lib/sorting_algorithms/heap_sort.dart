import 'package:dsa_in_dart/trees/heap/heap.dart';

void main() {
  var myList = [12, 45, 7, 9, 67, 2, 18];
  var myListN = heapSort(myList);
  print(myListN);

  print("\nSECOND EXAMPLE WITH SECOND IMPLEMENTATION\n");
  final list = [45, 1, 4, 89, 10, 3];
  print(list);
  list.heapsortInPlace();
  print(list);
}

/* 
    Heap Sort
      Heapsort is a comparison-based algorithm that sorts a list in ascending order using a heap. 
      It takes advantage of 'heap' - a partially sorted binary tree

    Qualities of a Heap:
      1. In a max-heap: all parent nodes are larger than or equal to their children.
      2. In a min-heap: all parent nodes are smaller than or equal to their children.

    NB: Once you have a heap, this sorting algorithm works by repeatedly removing the highest priority value from the top of the heap.


    PERFORMANCE
      1. The performance of heapsort is O(n log n) for its best, worst and average cases
         This is is because you have to traverse the whole list once, and every time you swap elements, you must perform a down-sift, which is an O(log n) operation.
      2. The space complexity of the first heap implementation is linear while the second implemention has space complexity of O(1)
    
    ABOUT IMPLEMENTATION
      The algorithm works by moving the values from the top of the heap to an ordered list (1st implementation). This can be performed in place if you use an index to separate the end of the heap from the sorted list elements (2nd implementation).


*/

//////////////////// First Method Using Heap   //////////////////////////////
///
List<E> heapSort<E extends Comparable<dynamic>>(List<E> list) {
  final heap = Heap<E>(
    elements: list.toList(),
    priority: Priority.min,
  );

  final sorted = <E>[];

  while (!heap.isEmpty) {
    final value = heap.remove();
    sorted.add(value!);
  }

  return sorted;
}

////////////// Second Method: Promoting In-Place Sorting (Using Single List) ///////////////////////
///

extension HeapSort<E extends Comparable<dynamic>> on List<E> {
  int _leftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }

  int _rightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }

  void _swapValues(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }

  // _siftDown swaps a parent value with its left or right child if one of them is larger,
  // and continues to do so until the parent finds its correct place in the heap.

  void _siftDown({required int start, required int end}) {
    var parent = start;

    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);

      var chosen = parent;

      if (left < end && this[left].compareTo(this[chosen]) > 0) {
        chosen = left;
      }

      if (right < end && this[right].compareTo(this[chosen]) > 0) {
        chosen = right;
      }

      if (chosen == parent) return;
      _swapValues(parent, chosen);
      parent = chosen;
    }
  }

  // The actual heapsort inplace function
  void heapsortInPlace() {
    if (isEmpty) return;

    // Turn to max heap (heapify)
    final start = length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(start: i, end: length);
    }

    for (var end = length - 1; end > 0; end--) {
      _swapValues(0, end);
      _siftDown(start: 0, end: end);
    }
  }
}
