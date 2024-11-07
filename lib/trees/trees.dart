void main() {
  final rootNode = TreeNode("Obum");
  final node1 = TreeNode("December");
  final node2 = TreeNode("November");

  rootNode.add(node1);
  rootNode.add(node2);
}

/* 
  TREES

  Trees can be used to solve issues that demand high performance:
    1. Complex Search
    2. Manipulating sorted data
    3. Solving hierarchical problems

  Root: is the topmost node

*/

class TreeNode<T> {
  TreeNode(this.value);
  T value;
  List<TreeNode<T>> children = [];

  void add(TreeNode<T> child) {
    children.add(child);
  }
}
