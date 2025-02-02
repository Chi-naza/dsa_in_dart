import 'package:dsa_in_dart/sorting_algorithms/swappable.dart';

void main() {
  var myList = [7, 5, 11, 45, 7, 12, 90, 45];
  print("Main List $myList");

  bubbleSort(myList);
  print("Sorted List $myList");
}

/* 
  0(n2) Time Complexity Sorting Algorithms:
    - 0(n2) = Quadratic Time Complexity is not a good performance.
    - One advantage of these algorithms is that they have constant O(1) space complexity, making them attractive for certain applications where memory is limited.
    - For small data sets, these sorting algorithms compare very favorably against more complex sorts.

  Bubble Sort
    This is one of the straightforward sorts. It repeatedly compares adjacent values and swaps them.
    - The larger values will 'bubble up' to the end of the collection

  
  NB: 
    • For a collection of length n, you need to do at most n - 1 passes.
    • Bubble sort has a best time complexity of O(n) if it’s already sorted, and a worst and average time complexity of O(n2).
    • And this quality doesn't make it a very efficient sorting algorithm
      

*/

void bubbleSort<E extends Comparable<dynamic>>(List<E> list) {
  for (var end = list.length - 1; end > 0; end--) {
    bool swapped = false;

    for (var current = 0; current < end; current++) {
      if (list[current].compareTo(list[current + 1]) > 0) {
        list.swap(current, current + 1);
        swapped = true;
      }
    }

    if (!swapped) return;
  }
}
