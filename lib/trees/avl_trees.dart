import 'dart:math' as math;

void main() {
  final tree = AVLTree<int>();
  tree.insert(15);
  tree.insert(10);
  tree.insert(16);
  tree.insert(18);
  print(tree);

  tree.remove(10);
  print(tree);

  tree.insert(5);
  tree.insert(45);
  print(tree);

  tree.insert(47);
  print(tree);
}

/* 
  AVL TREE:
  This helps to make a balanced tree. Binary Search Trees and AVL Trees share a lot in common
  The balancing is done by measuring the balance of the tree - this done by measuring the height.

  +Height: height of a node is the longest distance from the current node to a leaf node

  Types or States of Balance
    1. Perfect Balance: every level of a tree is filled with nodes
    2. Balanced: every level of the tree must be filled except the bottom level
    2. Unbalanced: different levels of the tree are not filled. 

  NB: 
    1. It is practically rare to have a perfectly balanced trees. You can always have balanced trees.
    AVL trees help and unbalanced tree to attain the height of balance at least.
    2. Keeping the tree balanced gives the find, insert and remove operations an O(log n) time complexity.
    3. AVL trees maintain balance by adjusting the structure of the tree when the tree becomes unbalanced.
    4. The procedure used for balancing Binary Search Trees is known as "rotation"
  
  Balance Factor: is the height difference between the left and right nodes.
  
*/

class AVLTree<E extends Comparable<dynamic>> {
  AVLNode<E>? root;

  // INSERTION
  void insert(E value) {
    root = _insertAt(root, value);
  }

  AVLNode<E> _insertAt(AVLNode<E>? node, E value) {
    if (node == null) {
      return AVLNode(value);
    }
    if (value.compareTo(node.value) < 0) {
      node.leftChild = _insertAt(node.leftChild, value);
    } else {
      node.rightChild = _insertAt(node.rightChild, value);
    }
    final balancedNode = balanced(node);
    balancedNode.height = 1 +
        math.max(
          balancedNode.leftHeight,
          balancedNode.rightHeight,
        );
    return balancedNode;
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

  AVLNode<E>? _remove(AVLNode<E>? node, E value) {
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

    final balancedNode = balanced(node);
    balancedNode.height = 1 +
        math.max(
          balancedNode.leftHeight,
          balancedNode.rightHeight,
        );
    return balancedNode;
  }

  // AVL Specifics

  // left rotate
  AVLNode<E> leftRotate(AVLNode<E> node) {
    final pivot = node.rightChild!;
    node.rightChild = pivot.leftChild;
    pivot.leftChild = node;

    node.height = 1 +
        math.max(
          node.leftHeight,
          node.rightHeight,
        );

    pivot.height = 1 +
        math.max(
          pivot.leftHeight,
          pivot.rightHeight,
        );

    return pivot;
  }

  // right rotate
  AVLNode<E> rightRotate(AVLNode<E> node) {
    final pivot = node.leftChild!;
    node.leftChild = pivot.rightChild;
    pivot.rightChild = node;

    node.height = 1 +
        math.max(
          node.leftHeight,
          node.rightHeight,
        );
    pivot.height = 1 +
        math.max(
          pivot.leftHeight,
          pivot.rightHeight,
        );
    return pivot;
  }

  // right-left-rotate
  AVLNode<E> rightLeftRotate(AVLNode<E> node) {
    if (node.rightChild == null) {
      return node;
    }
    node.rightChild = rightRotate(node.rightChild!);
    return leftRotate(node);
  }

  // left-right-rotate
  AVLNode<E> leftRightRotate(AVLNode<E> node) {
    if (node.leftChild == null) {
      return node;
    }
    node.leftChild = leftRotate(node.leftChild!);
    return rightRotate(node);
  }

  // find-out-if-a-tree-is-balanced-or-not
  AVLNode<E> balanced(AVLNode<E> node) {
    switch (node.balanceFactor) {
      case 2:
        // suggests left child is heavier: needs right-rotation or left-right
        final left = node.leftChild;
        if (left != null && left.balanceFactor == -1) {
          return leftRightRotate(node);
        } else {
          return rightRotate(node);
        }
      case -2:
        // suggests right child is heavier: needs left-rotation or right-left
        final right = node.rightChild;
        if (right != null && right.balanceFactor == 1) {
          return rightLeftRotate(node);
        } else {
          return leftRotate(node);
        }
      default:
        return node;
    }
  }

  @override
  String toString() => root.toString();
}

extension _MinFinder<E> on AVLNode<E> {
  AVLNode<E> get min => leftChild?.min ?? this;
}

class AVLNode<T> {
  AVLNode(this.value);
  T value;
  AVLNode<T>? leftChild;
  AVLNode<T>? rightChild;

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
    AVLNode<T>? node, [
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

  // AVL Specifics
  int height = 0;

  int get balanceFactor => leftHeight - rightHeight;
  int get leftHeight => leftChild?.height ?? -1;
  int get rightHeight => rightChild?.height ?? -1;
}
