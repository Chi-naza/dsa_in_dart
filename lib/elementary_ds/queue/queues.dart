import 'package:dsa_in_dart/elementary_ds/linkedlist/doubly_linked_list.dart';
import 'package:dsa_in_dart/elementary_ds/queue/ring_buffer.dart';

void main() {
  // final myQueue = QueueList<String>();
  // myQueue.enqueue("Jokee");
  // myQueue.enqueue("Busyyy");
  // myQueue.enqueue("Kopta");

  // print(myQueue.dequeue());
  // print(myQueue._list);

  // linkedlist
  // final queue = QueueLinkedList<String>();
  // queue.enqueue('Ray');
  // queue.enqueue('Brian');
  // print(queue);

  // queue.dequeue();

  // print(queue);

  // RING BUFFER
  final queue = QueueRingBuffer<int>(4);
  queue.enqueue(456);
  queue.enqueue(12);
  queue.enqueue(345);
  // queue.enqueue(12);
  print(queue);
}

/* 
  QUEUES:
  Queues are handy when you need to maintain the order of your elements to process later.

  Queue Operations
    • enqueue: Insert an element at the back of the queue. Return true if the operation was successful.
    • dequeue: Remove the element at the front of the queue and return it.
    • isEmpty: Check if the queue is empty.
    • peek: Return the element at the front of the queue without removing it.

  Ways of Creating a Queue:
    1. List
    2. Doubly LinkedList
    3. Ring Buffer
    4. Two Stacks


  PROS & CONS
    1. QueueList is fast but has O(n) for dequeue operations. QueueLinkedList is faster for dequeue and has O(1) complexity. 
    However, every time you create a new element, it requires a relatively expensive dynamic allocation of memory for the new node. 
    By contrast, QueueList does bulk allocation, which is faster.

    2. To eliminate allocation overhead and maintain O(1) dequeues, use Ring Buffer
    
    3. RING BUFFER: despite having space complexity of O(n) just like a linkedList when adding a new elemnt,
    it is not as costly as linkedList since it maintains a constant space: doesn’t require new memory allocation internally when enqueuing new elements.





*/

abstract class Queue<E> {
  bool enqueue(E element);
  E? dequeue();
  bool get isEmpty;
  E? get peek;
}

// QUEUE THROUGH LIST
class QueueList<E> implements Queue<E> {
  final _list = <E>[];

  @override
  E? dequeue() {
    return (isEmpty) ? null : _list.removeAt(0);
  }

  @override
  bool enqueue(element) {
    _list.add(element);
    return true;
  }

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? get peek => (isEmpty) ? null : _list.first;

  @override
  String toString() => _list.toString();
}

// QUEUE THROUGH DOUBLY-LINKEDLIST
class QueueLinkedList<E> implements Queue<E> {
  final _list = DoublyLinkedList<E>();

  @override
  bool enqueue(E element) {
    _list.append(element);
    return true;
  }

  @override
  E? dequeue() => _list.pop();

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  E? get peek => _list.head?.value;

  @override
  String toString() => _list.toString();
}

/// QUEUE THROUGH RING/CIRCULAR BUFFER
///
class QueueRingBuffer<E> implements Queue<E> {
  QueueRingBuffer(int length) : _ringBuffer = RingBuffer<E>(length);

  final RingBuffer<E> _ringBuffer;

  @override
  bool enqueue(E element) {
    if (_ringBuffer.isFull) {
      return false;
    }
    _ringBuffer.write(element);
    return true;
  }

  @override
  E? dequeue() => _ringBuffer.read();

  @override
  bool get isEmpty => _ringBuffer.isEmpty;

  @override
  E? get peek => _ringBuffer.peek;

  @override
  String toString() => _ringBuffer.toString();
}
