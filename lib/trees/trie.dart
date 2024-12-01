void main() {
  //

  final trie = StringTrie();

  trie.insert("Hello World");
  trie.insert("Cat");
  trie.insert("Abuja");
  trie.insert("Emeka");
  trie.insert("cut");
  trie.insert("cute");

  trie.remove("cut");

  print(trie.contains("cut"));
  print(trie.contains("cute"));

  print(trie.matchPrefix("c"));
}

/*
 
  TRIE: Trie is a tree that specializes in storing data that can be represented as a collection,
    such as English words
    * Each node represents a single character

  USES:
    1. Look and searching for prefix-matching
    2. Like in Google Search
    3. Optimizes search and lookup of large collections

  NB: Tries are relatively memory efficient since individual nodes can be shared between many different values. 
  For example, “car,” “carbs,” and “care” can share the first three letters of the word

 */

class TrieNode<T> {
  TrieNode({this.key, this.parent});

  T? key;

  TrieNode<T>? parent;

  Map<T, TrieNode<T>?> children = {};

  bool isTerminating = false;
}

class StringTrie {
  TrieNode<int> root = TrieNode(key: null, parent: null);

  // Insert Items
  void insert(String text) {
    var current = root;

    for (var codeUnit in text.codeUnits) {
      current.children[codeUnit] ??= TrieNode(
        key: codeUnit,
        parent: current,
      );
      current = current.children[codeUnit]!;
    }

    current.isTerminating = true;
  }

  // Checking if Contains
  bool contains(String text) {
    var current = root;
    for (var codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) {
        return false;
      }
      current = child;
    }
    return current.isTerminating;
  }

  // Remove
  void remove(String text) {
    var current = root;

    for (final codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) {
        return;
      }
      current = child;
    }
    if (!current.isTerminating) {
      return;
    }

    current.isTerminating = false;

    while (current.parent != null &&
        current.children.isEmpty &&
        !current.isTerminating) {
      current.parent!.children[current.key!] = null;
      current = current.parent!;
    }
  }

  // String Matching
  List<String> matchPrefix(String prefix) {
    // 1
    var current = root;
    for (final codeUnit in prefix.codeUnits) {
      final child = current.children[codeUnit];
      if (child == null) {
        return [];
      }
      current = child;
    }

    return _moreMatches(prefix, current);
  }

  // Helper function for string-matching
  List<String> _moreMatches(String prefix, TrieNode<int> node) {
    List<String> results = [];

    if (node.isTerminating) {
      results.add(prefix);
    }

    for (final child in node.children.values) {
      final codeUnit = child!.key!;
      results.addAll(
        _moreMatches(
          '$prefix${String.fromCharCode(codeUnit)}',
          child,
        ),
      );
    }
    return results;
  }
}
