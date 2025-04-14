//
void main() {
  // final graph = AdjacencyList<String>();
  final graph = AdjacencyMatrix<String>();

  final singapore = graph.createVertex('Singapore');
  final tokyo = graph.createVertex('Tokyo');
  final hongKong = graph.createVertex('Hong Kong');
  final detroit = graph.createVertex('Detroit');
  final sanFrancisco = graph.createVertex('San Francisco');
  final washingtonDC = graph.createVertex('Washington DC');
  final austinTexas = graph.createVertex('Austin Texas');
  final seattle = graph.createVertex('Seattle');

  graph.addEdge(singapore, hongKong, weight: 300);
  graph.addEdge(singapore, tokyo, weight: 500);
  graph.addEdge(hongKong, tokyo, weight: 250);
  graph.addEdge(tokyo, detroit, weight: 450);
  graph.addEdge(tokyo, washingtonDC, weight: 300);
  graph.addEdge(hongKong, sanFrancisco, weight: 600);
  graph.addEdge(detroit, austinTexas, weight: 50);
  graph.addEdge(austinTexas, washingtonDC, weight: 292);
  graph.addEdge(sanFrancisco, washingtonDC, weight: 337);
  graph.addEdge(washingtonDC, seattle, weight: 277);
  graph.addEdge(sanFrancisco, seattle, weight: 218);
  graph.addEdge(austinTexas, sanFrancisco, weight: 297);

  print(graph);
}

/* 
    Graphs
      A graph is a data structure that captures relationships between objects. 
      It’s made up of vertices connected by edges.
      Graphs are an instrumental data structure that can model a wide range of things: 
       a. webpages on the internet, 
       b. the migration patterns of birds, 
       c. even protons in the nucleus of an atom

    Types of Graph
      - Weighted Graphs: In a weighted graph, every edge has a weight associated with it that represents the cost of using this edge.
      - Directed Graphs: This is a graph where the egdes have direction, and this can be restrictive because an edge may only permit traversal in one direction.
      - Undirected Graphs: It is a directed-graph where all the edges are bi-drectional.

    Adjacency List: this is the list of outgoing edges....for every vertex in the graph, the graph stores a list of outgoing edges.

    Adjacency Matrix: An adjacency matrix uses a two-dimensional grid or table to implement the graph data structure.

    *Sparse & Dense Graph:
      If there are few edges in your graph, then it is a sparse graph; otherwise, it is a dense graph.
      - Adjacency List will go well for a sparse graph while Adjacency matric will be good for a dense graph.
      - This is because adjacency-matrix gives access to the edges and weights more quickly, having time complexity of O(1).
    
    *Complete Graph:
      A dense graph in which every vertex has an edge to every other vertex is called a complete graph.
    
    NOTES:
      1. You can represent real-world relationships through vertices and edges.
      2. Think of vertices as objects and edges as the relationships between the objects.

*/

class Vertex<T> {
  const Vertex({required this.index, required this.data});
  final int index;
  final T data;

  @override
  String toString() => data.toString();
}

class Edge<T> {
  const Edge(this.source, this.destination, [this.weight]);
  final Vertex<T> source;
  final Vertex<T> destination;
  final double? weight;
}

enum EdgeType { directed, undirected }

abstract class Graph<E> {
  Iterable<Vertex<E>> get vertices;

  Vertex<E> createVertex(E data);

  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType,
    double? weight,
  });

  List<Edge<E>> edges(Vertex<E> source);

  double? weight(Vertex<E> source, Vertex<E> destination);
}

/// Adjacency List ///
class AdjacencyList<E> implements Graph<E> {
  final Map<Vertex<E>, List<Edge<E>>> _connections = {};
  var _nextIndex = 0;

  @override
  Iterable<Vertex<E>> get vertices => _connections.keys;

  @override
  Vertex<E> createVertex(E data) {
    final vertex = Vertex(
      index: _nextIndex,
      data: data,
    );
    _nextIndex++;

    _connections[vertex] = [];
    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    double? weight,
  }) {
    _connections[source]?.add(
      Edge(source, destination, weight),
    );

    if (edgeType == EdgeType.undirected) {
      _connections[destination]?.add(
        Edge(destination, source, weight),
      );
    }
  }

  @override
  List<Edge<E>> edges(Vertex<E> source) => _connections[source] ?? [];

  @override
  double? weight(Vertex<E> source, Vertex<E> destination) {
    final match = edges(source).where((edge) {
      return edge.destination == destination;
    });
    if (match.isEmpty) return null;
    return match.first.weight;
  }

  @override
  String toString() {
    final result = StringBuffer();

    _connections.forEach((vertex, edges) {
      final destinations = edges.map((edge) {
        return edge.destination;
      }).join(', ');

      result.writeln('$vertex --> $destinations');
    });
    return result.toString();
  }
}

//

/// Adjacency List ///

//

class AdjacencyMatrix<E> implements Graph<E> {
  final List<Vertex<E>> _vertices = [];
  final List<List<double?>?> _weights = [];
  var _nextIndex = 0;

  @override
  Iterable<Vertex<E>> get vertices => _vertices;

  @override
  Vertex<E> createVertex(E data) {
    final vertex = Vertex(
      index: _nextIndex,
      data: data,
    );
    _nextIndex++;
    _vertices.add(vertex);

    for (var i = 0; i < _weights.length; i++) {
      _weights[i]?.add(null);
    }

    final row = List<double?>.filled(
      _vertices.length,
      null,
      growable: true,
    );
    _weights.add(row);
    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    double? weight,
  }) {
    _weights[source.index]?[destination.index] = weight;

    if (edgeType == EdgeType.undirected) {
      _weights[destination.index]?[source.index] = weight;
    }
  }

  @override
  List<Edge<E>> edges(Vertex<E> source) {
    List<Edge<E>> edges = [];

    for (var column = 0; column < _weights.length; column++) {
      final weight = _weights[source.index]?[column];
      if (weight == null) continue;

      final destination = _vertices[column];
      edges.add(Edge(source, destination, weight));
    }
    return edges;
  }

  @override
  double? weight(Vertex<E> source, Vertex<E> destination) {
    return _weights[source.index]?[destination.index];
  }

  @override
  String toString() {
    final output = StringBuffer();

    for (final vertex in _vertices) {
      output.writeln('${vertex.index}: ${vertex.data}');
    }

    for (int i = 0; i < _weights.length; i++) {
      for (int j = 0; j < _weights.length; j++) {
        final value = (_weights[i]?[j] ?? '.').toString();
        output.write(value.padRight(6));
      }
      output.writeln();
    }

    return output.toString();
  }
}
