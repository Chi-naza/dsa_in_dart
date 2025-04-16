import 'package:dsa_in_dart/elementary_ds/queue/queues.dart';
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
  graph.addEdge(c, f, weight: 1);
  graph.addEdge(c, g, weight: 1);
  graph.addEdge(e, h, weight: 1);
  graph.addEdge(e, f, weight: 1);
  graph.addEdge(f, g, weight: 1);

  final vertices = graph.breadthFirstSearch(a);
  vertices.forEach(print);
}

/* 
  BFS:
  Breadth-first search (BFS) is an algorithm for traversing or searching a graph.

  Properties
    • BFS explores all the current vertex’s neighbors before traversing the next level of vertices.
    • It’s generally good to use this algorithm when your graph structure has many neighboring vertices or when you need to find out every possible outcome.
    • The queue data structure is used to prioritize traversing a vertex’s edges before diving down to a level deeper.
    • 


*/

extension BreadthFirstSearch<E> on Graph<E> {
  List<Vertex<E>> breadthFirstSearch(Vertex<E> source) {
    final queue = QueueStack<Vertex<E>>();
    Set<Vertex<E>> enqueued = {};
    List<Vertex<E>> visited = [];

    queue.enqueue(source);
    enqueued.add(source);

    while (true) {
      final vertex = queue.dequeue();
      if (vertex == null) break;

      visited.add(vertex);

      final neighborEdges = edges(vertex);
      for (final edge in neighborEdges) {
        if (!enqueued.contains(edge.destination)) {
          queue.enqueue(edge.destination);
          enqueued.add(edge.destination);
        }
      }
    }

    return visited;
  }
}
