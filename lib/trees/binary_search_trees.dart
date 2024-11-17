import 'package:dsa_in_dart/trees/binary_trees.dart';

void main() {
  var tree = BinarySearchTree<int>();

  tree.insert(3);
  tree.insert(10);
  tree.insert(4);
  tree.insert(045);
  tree.insert(2);
  tree.insert(25);

  // print(tree);

  print(tree.contains(2));
  print(tree);
  tree.remove(10);
  print(tree);
}

/* 
  BINARY SEARCH TREES (BST)
  BST is a data structure that facilitates fast lookup, insert and removal operations.

  BST Rules:
    1. The value of a left child must be less than the value of its parent.
    2. Consequently, the value of a right child must be greater than or equal to the value of its parent

  *Balanced and Unbalanced trees: An unbalanced tree is not well spread out, 
    even though it follows the rules.
    There is a concept of self-balancing trees which helps to keep a tree ballanced.

  Three(3) Major Operations In BST
    1. Insertion
    2. Finding or Searching elements
    3. Removal of elements
  
  * BST maintains time complexity of O(log n) in all these operation unlike Lists that has O(n)
  
  REMOVING ELEMENT: to remove a node that has two children, replace the node you removed with the smallest node in its right subtree.
    This will maintain the rules of BST and balance the tree after the removal.


*/

class BinarySearchTree<E extends Comparable<dynamic>> {
  BinaryNode<E>? root;

  // INSERTION
  void insert(E value) {
    root = _insertAt(root, value);
  }

  BinaryNode<E> _insertAt(BinaryNode<E>? node, E value) {
    if (node == null) {
      return BinaryNode(value);
    }
    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.rightChild, value);
    }

    return node;
  }

  // SEARCHING
  bool contains(E value) {
    var current = root;

    while (current != null) {
      if (current.value == value) {
        return true;
      }
      if (value.compareTo(current.value) < 0) {
        current = current.leftChild;
      } else {
        current = current.rightChild;
      }
    }

    return false;
  }

  // REMOVAL
  void remove(E value) {
    root = _remove(root, value);
  }

  BinaryNode<E>? _remove(BinaryNode<E>? node, E value) {
    if (node == null) return null;

    if (value == node.value) {
      // if it is a leaf node, return null
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }
      // if left child is null, remove the right
      if (node.leftChild == null) {
        return node.rightChild;
      }
      // if right child is null, remove the left
      if (node.rightChild == null) {
        return node.leftChild;
      }

      // if node has two chilldren: find min node from the rightChild.
      // When found swap it with the node to be deleted.
      node.value = node.rightChild!.min.value;
      //test
      print("MIN: ${node.value}");
      //  Then remove it
      node.rightChild = _remove(node.rightChild, value);
    } else if (value.compareTo(node.value) < 0) {
      node.leftChild = _remove(node.leftChild, value);
    } else {
      node.rightChild = _remove(node.rightChild, value);
    }
    return node;
  }

  @override
  String toString() => root.toString();
}

extension _MinFinder<E> on BinaryNode<E> {
  BinaryNode<E> get min => leftChild?.min ?? this;
}
