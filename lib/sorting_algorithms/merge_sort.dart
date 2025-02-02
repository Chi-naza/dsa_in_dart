void main() {
  var myList = [7, 5, 100, 3, 8, 2, 13, 0.1];
  print("Main List $myList");
  var sorted = mergeSort(myList);
  print("Sorted List $sorted");
}

/* 
  Merge Sort
    The idea behind merge sort is to divide and conquer — to break up a big problem into several smaller, 
    easier-to-solve problems and then combine the solutions into a final result.
    * Merge sort works by splitting the original list into many individual lists of length one. It then merges pairs of lists into larger and larger sorted lists until the entire collection is sorted.


  Performance: The best, worst and average time complexity of merge sort is quasilinear, or O(n log n), which isn’t too bad.
   
  
  NB: 
    • Merge sort is a "stable" sorting algorithm. We have talked about stability - Elements of the same type retain their relative order after being sorted
    • It is a divide-and-conquer algorithm.
    • Merge sort has a time complexity of O(n log n).
    • Unlike the 3 previous algorithms, MergeSort does not sort "in place" (it does not use swap to move things around, but rather allocates additional memory to do its work), so the space complexity is also O(n log n)
         

*/

List<E> mergeSort<E extends Comparable<dynamic>>(List<E> list) {
  if (list.length < 2) return list;

  final middle = list.length ~/ 2;
  final left = mergeSort(list.sublist(0, middle));
  final right = mergeSort(list.sublist(middle));

  return _merge(left, right);
}

List<E> _merge<E extends Comparable<dynamic>>(List<E> listA, List<E> listB) {
  int indexA = 0;
  int indexB = 0;

  final result = <E>[];

  // Starting from the beginning of listA and listB, you sequentially compare the values. If you’ve reached the end of either list, there’s nothing else to compare.
  while (indexA < listA.length && indexB < listB.length) {
    final valueA = listA[indexA];
    final valueB = listB[indexB];

    if (valueA.compareTo(valueB) < 0) {
      result.add(valueA);
      indexA += 1;
    } else if (valueA.compareTo(valueB) > 0) {
      result.add(valueB);
      indexB += 1;
    } else {
      result.add(valueA);
      result.add(valueB);
      indexA += 1;
      indexB += 1;
    }
  }

  if (indexA < listA.length) {
    result.addAll(listA.getRange(indexA, listA.length));
  }

  if (indexB < listB.length) {
    result.addAll(listB.getRange(indexB, listB.length));
  }

  return result;
}
