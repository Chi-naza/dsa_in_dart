import 'package:dsa_in_dart/elementary_ds/queue/queues.dart';

void main() {
  final rootNode = TreeNode("Obum");
  final node1 = TreeNode("December");
  final node2 = TreeNode("November");

  rootNode.add(node1);
  rootNode.add(node2);
  node1.add(TreeNode("Aijalong"));
  node1.add(TreeNode("Papyrus"));
  node2.add(TreeNode("Gofun"));
  node1.add(TreeNode("Apams"));

  // rootNode.forEachDepthFirst((node) => print(node.value));
  // rootNode.forEachLevelOrder((node) => print(node.value));

  print(rootNode.search("Apams"));
}

/* 
  TREES

  Trees can be used to solve issues that demand high performance:
    1. Complex Search
    2. Manipulating sorted data
    3. Solving hierarchical problems

  Root: is the topmost node

  Traversal Algorithms:
    1. Depth-First Traversal: visits each node as deep as possible before backtracking
    2. Level-Order Traversal: visits a node based on how deep the node is. Visits level by level

*/

class TreeNode<T> {
  TreeNode(this.value);
  T value;
  List<TreeNode<T>> children = [];

  void add(TreeNode<T> child) {
    children.add(child);
  }

  // depth first traversal
  void forEachDepthFirst(void Function(TreeNode<T> node) performAction) {
    performAction(this);
    for (final child in children) {
      child.forEachDepthFirst(performAction);
    }
  }

  // level order traversal
  void forEachLevelOrder(void Function(TreeNode<T> node) performAction) {
    final queue = QueueStack<TreeNode<T>>();
    performAction(this);
    children.forEach(queue.enqueue);
    var node = queue.dequeue();
    while (node != null) {
      performAction(node);
      node.children.forEach(queue.enqueue);
      node = queue.dequeue();
    }
  }

  // search and find - using level order traversal
  TreeNode? search(T value) {
    TreeNode? result;
    forEachLevelOrder((node) {
      if (node.value == value) {
        result = node;
      }
    });
    return result;
  }
}
