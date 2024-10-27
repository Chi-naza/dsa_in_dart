void main() {
  Node n1 = Node(value: "Adamma");
  Node n2 = Node(value: 1);
  Node n3 = Node(value: "Socrates");

  n1.next = n2;
  n2.next = n3;

  LinkedList myLinkedList = LinkedList();
  myLinkedList.push("Christian");
  myLinkedList.push("Ebuka");
  myLinkedList.append(456);

  var sortAfterNode = myLinkedList.nodeAt(2);

  myLinkedList.insertAfter(sortAfterNode!, "Nkemdilim");

  // print(myLinkedList);

  // print(myLinkedList.removeLast());
  // print(myLinkedList.pop());
  // print(myLinkedList.removeAfter(sortAfterNode));

  // print(myLinkedList);

  for (var a in myLinkedList) {
    print(a);
  }
}

// A LinkedList is a chain of nodes

/*
  A linkedlist node contains two info:
    1. A value
    2. Reference to the next node

  * A reference of null is the last node

  * head: first element of a linkedlist
  * tail: last element of a linkedlist

  Three(3) ways of adding items to a linkedList
    1. push: Adds a value at the front of the list.
    2. append: Adds a value at the end of the list.
    3. insertAfter: Adds a value after a particular node in the list.
  
  Ways of removing items/nodes from a linkedList
    1. pop: Removes the value at the front of the list.
    2. removeLast: Removes the value at the end of the list.
    3. removeAfter: Removes the value after a particular node in the list.

*/

class Node<T> {
  Node({required this.value, this.next});
  T value;
  Node<T>? next;

  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? head;
  Node<E>? tail;

  @override
  bool get isEmpty => head == null;

  // Pushing to a new LinkedList. The new node is both head and tail
  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  // Appending in isNotEmpty list, the new node becomes the current tail
  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }

    tail!.next = Node(value: value);
    tail = tail!.next;
  }

  // Finding a node at a particular index
  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  // Inserting a node after a specified node. You get a particular node by using nodeAt
  Node<E> insertAfter(Node<E> node, E value) {
    if (tail == node) {
      append(value);
      return tail!;
    }

    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  // Remove from the head: front of the list
  E? pop() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  // Remove the last item/node
  E? removeLast() {
    if (head?.next == null) return pop();

    var current = head;
    while (current!.next != tail) {
      current = current.next;
    }

    final value = tail?.value;
    tail = current;
    tail?.next = null;
    return value;
  }

  // Removing from the middle of the linkedList or after a particular specified node
  E? removeAfter(Node<E> node) {
    final value = node.next?.value;
    if (node.next == tail) {
      tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty linkedlist';
    return head.toString();
  }

  @override
  Iterator<E> get iterator => _LinkedListIterator(this);
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(LinkedList<E> list) : _list = list;
  final LinkedList<E> _list;

  Node<E>? _currentNode;

  // Getting the current value
  @override
  E get current => _currentNode!.value;

  bool _firstPass = true;

  // Point the iterator to the next value following the CURRENT from your iterable
  // Returning false means that the current is the last item of the iterable
  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}
