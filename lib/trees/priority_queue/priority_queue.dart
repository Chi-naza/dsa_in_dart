import 'package:dsa_in_dart/elementary_ds/queue/queues.dart';
import 'package:dsa_in_dart/trees/heap/heap.dart';
export 'package:dsa_in_dart/trees/heap/heap.dart' show Priority;

void main() {
  var pq = PriorityQueue<int>(elements: [1, 2, 3, 4, 5, 6, 7, 8, 9]);
  print(pq);
  print(pq.dequeue());
  print(pq);
  print(pq.peek);
}

/*
 
  PRIORITY QUEUE
    * A priority queue is another version of a queue in which elements are dequeued in priority order instead of FIFO order.

  Priority Queues Can Be:
    1. Max priority -  element at the front is always the largest.
    2. Min priority - element at the front is always the smallest.

  APPLICATIONS
    1. Dijkstra’s algorithm: which uses a priority queue to calculate the minimum cost
    2. Heapsort: which can be implemented using a priority queue.
    3. A* pathfinding algorithm: which uses a priority queue to track the unexplored routes that will produce the path with the shortest length. Etc.


*/

class PriorityQueue<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueue({List<E>? elements, Priority priority = Priority.max}) {
    _heap = Heap<E>(elements: elements, priority: priority);
  }

  late Heap<E> _heap;

  @override
  E? dequeue() => _heap.remove();

  @override
  bool enqueue(E element) {
    _heap.insert(element);
    return true;
  }

  @override
  bool get isEmpty => _heap.isEmpty;

  @override
  E? get peek => _heap.peek;

  @override
  String toString() {
    return _heap.toString();
  }
}
