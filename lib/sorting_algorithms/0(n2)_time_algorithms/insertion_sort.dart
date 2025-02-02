import 'package:dsa_in_dart/sorting_algorithms/swappable.dart';

void main() {
  var myList = [7, 5, 100, 3, 8, 2, 13];
  print("Main List $myList");
  insertionSort<int>(myList);
  print("Main List $myList");
}

/* 
  Insertion Sort
    The idea of insertion sort is similar to how many people sort a hand of cards. 
    You start with the card at one end and then go through the unsorted cards one at a time, 
    taking each one as you come to it and inserting it in the correct location among your previously sorted cards.
   

  
  NB: 
    • Like bubble sort and selection sort, insertion sort has an average time complexity of O(n2)
    • The more the data is already sorted, the less work it needs to do
    • So, it has best time complexity of O(n) if the data is already sorted.
    • Insertion sort is one of the fastest sorting algorithms if the data is already sorted.


  CONCEPT OF STABILITY
    - A sorting algorithm is called stable if the elements of the same type retain their order after being sorted.
    - Most of the time it doesn’t matter if a sort is stable or not. However, there are situations when it does matter. 
      For example, say you sort a list of cities from around the world into alphabetical order. 
      If you then sort that same list again by country, the cities within each country will still be in alphabetical order as long as the sort was stable. 
      Using an unstable sort, on the other hand, would result in the cities potentially losing their sort order.
    - Of the three sorting algorithms considered so far, bubble sort and insertion sort are both stable
    
      

*/

void insertionSort<E extends Comparable<dynamic>>(List<E> list) {
  // current  is the index of the element you want to sort in this pass.
  for (var current = 1; current < list.length; current++) {
    // keep shifiting the element you want to sort leftwards until it settles on a good position
    for (var shifting = current; shifting > 0; shifting--) {
      if (list[shifting].compareTo(list[shifting - 1]) < 0) {
        list.swap(shifting, shifting - 1);
      } else {
        break;
      }
    }
  }
}
