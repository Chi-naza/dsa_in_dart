import 'package:dsa_in_dart/elementary_ds/stack.dart';
import 'package:dsa_in_dart/graphs/graphs.dart';

void main() {
  final graph = AdjacencyList<String>();

  final a = graph.createVertex('A');
  final b = graph.createVertex('B');
  final c = graph.createVertex('C');
  final d = graph.createVertex('D');
  final e = graph.createVertex('E');
  final f = graph.createVertex('F');
  final g = graph.createVertex('G');
  final h = graph.createVertex('H');

  graph.addEdge(a, b, weight: 1);
  graph.addEdge(a, c, weight: 1);
  graph.addEdge(a, d, weight: 1);
  graph.addEdge(b, e, weight: 1);
  graph.addEdge(c, g, weight: 1);
  graph.addEdge(e, f, weight: 1);
  graph.addEdge(e, h, weight: 1);
  graph.addEdge(f, g, weight: 1);
  graph.addEdge(f, c, weight: 1);

  // final vertices = graph.depthFirstSearch(a);
  // vertices.forEach(print);

  print(graph);
  print(graph.hasCycle(d));
}

/* 
  DFS:
    To perform Depth-first search (DFS), you start with a given source vertex and attempt to explore a branch as far as possible until you reach the end. 
    At this point, you backtrack and explore the next available branch until you find what you’re looking for or 
    until you’ve visited all the vertices.

  Properties of DFS
    • DFS explores a branch as far as possible before backtracking to the next branch.
    • The stack data structure allows you to backtrack: its last-in-first-out approach helps with backtracking.


  Applications of DFS
    • Topological sorting.
    • Detecting a cycle.
    • Pathfinding, such as in maze puzzles. etc
  
  Cycles In Graph
    A graph is said to have a cycle when a path of edges and vertices leads back to the same source.
    • Such graphs are said to be cyclic. Graphs that don't have cycles are acyclic.
    • DFS is useful for finding whether a graph contains cycles.
    • Two vertices can make a cycle in a directed graph; undirected graphs need at least three vertices to make a cycle.


*/

extension DepthFirstSearch<E> on Graph<E> {
  List<Vertex<E>> depthFirstSearch(Vertex<E> source) {
    final stack = Stack<Vertex<E>>();
    final pushed = <Vertex<E>>{};
    final visited = <Vertex<E>>[];

    stack.push(source);
    pushed.add(source);
    visited.add(source);

    outerLoop:
    while (stack.isNotEmpty) {
      final vertex = stack.peek;

      final neighbors = edges(vertex);

      for (final edge in neighbors) {
        if (!pushed.contains(edge.destination)) {
          stack.push(edge.destination);
          pushed.add(edge.destination);
          visited.add(edge.destination);

          continue outerLoop;
        }
      }

      stack.pop();
    }

    return visited;
  }
}

// For Checking out Cyclic Graphs
extension CyclicGraph<E> on Graph<E> {
  bool _hasCycle(Vertex<E> source, Set<Vertex<E>> pushed) {
    pushed.add(source);
    final neighbors = edges(source);

    for (final edge in neighbors) {
      if (!pushed.contains(edge.destination)) {
        if (_hasCycle(edge.destination, pushed)) {
          return true;
        }
      } else {
        return true;
      }
    }

    pushed.remove(source);
    return false;
  }

  bool hasCycle(Vertex<E> source) {
    Set<Vertex<E>> pushed = {};
    return _hasCycle(source, pushed);
  }
}
