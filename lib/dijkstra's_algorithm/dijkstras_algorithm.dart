import 'package:dsa_in_dart/graphs/graphs.dart';
import 'package:dsa_in_dart/trees/priority_queue/priority_queue.dart';

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

  graph.addEdge(a, b, weight: 8, edgeType: EdgeType.directed);
  graph.addEdge(a, f, weight: 9, edgeType: EdgeType.directed);
  graph.addEdge(a, g, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(g, c, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(c, b, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(c, e, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(e, b, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(e, d, weight: 2, edgeType: EdgeType.directed);
  graph.addEdge(b, e, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(b, f, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(f, a, weight: 2, edgeType: EdgeType.directed);
  graph.addEdge(h, g, weight: 5, edgeType: EdgeType.directed);
  graph.addEdge(h, f, weight: 2, edgeType: EdgeType.directed);

  final dijkstra = Dijkstra(graph);
  print(dijkstra.shortestPaths(a));

  print("\nFind a Paticular path (shortest/cheapest) from A to B");
  final path = dijkstra.findShortestPathForADestination(a, b);
  print(path);
}

/* 
  Dijkstra's Algorithm:
    To 
    - The algorithm works with weighted graphs, both directed and undirected, to calculate the optimal routes from one vertex to all others in the graph.
    - Dijkstra’s algorithm is known as a greedy algorithm: that means it picks the most optimal path at every step along the way.

  Applications of Dijkstra's Algorithm:
    • Useful in GPS networks to help find the shortest & fastest path between two locations. (Mapping)
    • Telephone networks: routing calls to the highest-bandwidth paths available in the network.
    • Communicable disease transmission: Discovering where biological diseases are spreading the fastest.

  How Dijkstra's Algorithm Works:
    - Imagine a directed graph with vertices and edges representing a road map. 
    - The vertices represent physical locations, and the edges represent one-way routes of a given cost between locations.
    - While edge weight can refer to the actual cost, it’s also commonly referred to as distance, which fits with the paradigm of finding the shortest route.
      However, if you like the word cost, you can think of route finding algorithms as looking for the cheapest route.
    
*/

class Pair<T> implements Comparable<Pair<T>> {
  Pair(this.distance, [this.vertex]);
  double distance;
  Vertex<T>? vertex;
  @override
  int compareTo(Pair<T> other) {
    if (distance == other.distance) return 0;
    if (distance > other.distance) return 1;
    return -1;
  }

  @override
  String toString() => '($distance, $vertex)';
}

class Dijkstra<E> {
  final Graph<E> graph;

  Dijkstra(this.graph);

  Map<Vertex<E>, Pair<E>?> shortestPaths(Vertex<E> source) {
    final queue = PriorityQueue<Pair<E>>(priority: Priority.min);
    final visited = <Vertex<E>>{};
    // "paths" holds list of all the distance to a particular vertex from the source
    final paths = <Vertex<E>, Pair<E>?>{};

    for (final vertex in graph.vertices) {
      paths[vertex] = null;
    }

    queue.enqueue(Pair(0, source));
    paths[source] = Pair(0);
    visited.add(source);

    // while the queue is empty: queue holds list of unvisited vertices.
    while (!queue.isEmpty) {
      final current = queue.dequeue()!;
      final savedDistance = paths[current.vertex]!.distance;
      // if the new distance is greater/costlier than the one already saved in the "paths", THEN CONTINUE
      if (current.distance > savedDistance) continue;

      // keep track of the visited vertex by adding this to visited. And this happens if the new distance is lesser, otherwise the loop will CONTINUE.
      visited.add(current.vertex!);

      // At this point, you can check all the costs/edge-weights in this current vertex and update their distance in "queue" & "paths" if the cost/distance is lesser.
      for (final edge in graph.edges(current.vertex!)) {
        final neighbor = edge.destination;

        if (visited.contains(neighbor)) continue;

        final weight = edge.weight ?? double.infinity;
        final totalDistance = current.distance + weight;

        final knownDistance = paths[neighbor]?.distance ?? double.infinity;

        if (totalDistance < knownDistance) {
          paths[neighbor] = Pair(totalDistance, current.vertex);
          queue.enqueue(Pair(totalDistance, neighbor));
        }
      }
    }

    // Once all the discoverable vertices have been visited and the priority queue is empty, you return the map of the shortest paths. Dijkstra’s algorithm is complete.
    return paths;
  }

  List<Vertex<E>> findShortestPathForADestination(
    Vertex<E> source,
    Vertex<E> destination, {
    Map<Vertex<E>, Pair<E>?>? paths,
  }) {
    // Get all the paths
    final allPaths = paths ?? shortestPaths(source);

    // If destination is not in the paths, return
    if (!allPaths.containsKey(destination)) return [];
    var current = destination;

    // Add this destination to a new list (a list for holding the paths to this destination)
    final path = <Vertex<E>>[current];

    // Step back to all the paths that leads to this destination until you get to the source
    while (current != source) {
      final previous = allPaths[current]?.vertex;
      if (previous == null) return [];
      path.add(previous);
      current = previous;
    }

    // return the new path list in a reversed order
    return path.reversed.toList();
  }
}
