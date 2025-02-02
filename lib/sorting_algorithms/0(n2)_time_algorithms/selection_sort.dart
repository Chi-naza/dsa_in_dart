import 'package:dsa_in_dart/sorting_algorithms/swappable.dart';

void main() {
  var myList = [7, 5, 11, 3, 7, 12, 90, 1];
  print("Main List $myList");
  selectionSort(myList);
  print("Sorted List $myList");
}

/* 
  SELECTION SORT
   This follows the idea of bubble sort, but reduces the number of passes or iterations to be made.
   Selection sort will only swap at the end of each pass.

  
  NB: Selection sort has a best, worst and average time complexity of O(n2), which is fairly dismal.
      *It does perform better than bubble sort!

*/

void selectionSort<E extends Comparable<dynamic>>(List<E> list) {
  for (var start = 0; start < list.length - 1; start++) {
    var lowest = start;

    for (var next = start + 1; next < list.length; next++) {
      if (list[next].compareTo(list[lowest]) < 0) {
        lowest = next;
      }
    }

    if (lowest != start) {
      list.swap(lowest, start);
    }
  }
}
