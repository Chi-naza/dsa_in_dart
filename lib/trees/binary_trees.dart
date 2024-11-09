void main() {
  final tree = BinaryNode(55);
  final node1 = BinaryNode(1);
  final node2 = BinaryNode(2);
  final node3 = BinaryNode(3);
  final node4 = BinaryNode(4);
  final node5 = BinaryNode(5);
  final node6 = BinaryNode(6);

  tree.leftChild = node1;
  tree.rightChild = node2;

  node1.leftChild = node3;
  node2.leftChild = node4;
  node2.rightChild = node5;

  node3.leftChild = node6;

  tree.traversePostOrder(print);
}

/* 
  BINARY TREES
  Binary tree is a tree where each node has at most two children, often referred to as the left and right children.

  Traversal Algorithms for Binary Trees:
    1. In-Order Traversal: starts from the root/current node, if there is a left child, it visits it first, 
    before visiting the parent, after the parent, it goes for the right child (if the right child exists)

    2. Pre-Order Traversal: this visits the current node first, then recursively visits the left and right child.

    3. Post-Order Traversal: this visits the current node after the left and right child have been visited recursively.
    Given any node, you will visit the children before visiting the node.


*/

class BinaryNode<T> {
  BinaryNode(this.value);
  T value;
  BinaryNode<T>? leftChild;
  BinaryNode<T>? rightChild;

  @override
  String toString() {
    return _diagram(this);
  }

  // In-order
  void traverseInOrder(void Function(T value) action) {
    leftChild?.traverseInOrder(action);
    action(value);
    rightChild?.traverseInOrder(action);
  }

  // Pre-order
  void traversePreOrder(void Function(T value) action) {
    action(value);
    leftChild?.traversePreOrder(action);
    rightChild?.traversePreOrder(action);
  }

  // Post-order
  void traversePostOrder(void Function(T value) action) {
    leftChild?.traversePostOrder(action);
    rightChild?.traversePostOrder(action);
    action(value);
  }

  String _diagram(
    BinaryNode<T>? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.value}\n';
    }
    final a = _diagram(
      node.rightChild,
      '$top ',
      '$top┌──',
      '$top│ ',
    );

    final b = '$root${node.value}\n';

    final c = _diagram(
      node.leftChild,
      '$bottom│ ',
      '$bottom└──',
      '$bottom ',
    );
    return '$a$b$c';
  }
}
