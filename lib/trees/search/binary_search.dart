void main() {
  final list = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150];
  final search31 = list.indexOf(19);
  final binarySearch31 = list.binarySearch(19);
  print('indexOf: $search31');
  print('binarySearch: $binarySearch31');
}

extension SortedList<E extends Comparable<dynamic>> on List<E> {
  int? binarySearch(E value, [int? start, int? end]) {
    final startIndex = start ?? 0;
    final endIndex = end ?? length;

    if (startIndex >= endIndex) {
      return null;
    }

    final size = endIndex - startIndex;
    final middle = startIndex + size ~/ 2;

    if (this[middle] == value) {
      return middle;
    } else if (value.compareTo(this[middle]) < 0) {
      return binarySearch(value, startIndex, middle);
    } else {
      return binarySearch(value, middle + 1, endIndex);
    }
  }
}
