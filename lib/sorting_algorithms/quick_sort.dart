void main() {
  var dList = [1, 45, 3, 9, 5, 0];
  var sorted = quicksortNaive(dList);

  print(sorted);

  // final list = [8, 2, 10, 0, 9, 18, 9, -1, 5];
  // quicksortHoare(list, 0, list.length - 1);
  // print(list);

  // final list = [8, 7, 6, 5, 4, 3, 2, 1];
  // quicksortMedian(list, 0, list.length - 1);
  // print(list);

  final list = [8, 2, 2, 8, 9, 5, 9, 2, 8];
  quicksortDutchFlag(list, 0, list.length - 1);
  print(list);
}

/* 
    Quick Sort
      Quicksort is another comparism-based algorithm. It is unique in the sense that it chooses a "pivot" and divides the list into partitions
      - It divides the list into 3 partitions: values less than the pivot, values equal to the pivot, and values greater than the pivot.
      - It recursively divides the other partitions until there a single element in each partition. (At the end, you have a sorted list)
      - The pivot can be any value from the list

    *Lomuto's Algorithm: 
      - Always chooses the last element as pivot
      - In the naïve implementation of quicksort, you created three new lists and filtered the unsorted list three times. 
        Lomuto’s algorithm performs the partitioning in place. That’s much more efficient!

    *Hoare’s Algorithm: 
      - Always chooses the first element as pivot
      - There are far fewer swaps with Hoare’s algorithm compared to Lomuto’s algorithm.
        Because it creates two partitions instead of three.

    #Effects of a bad pivot choice
      - Choosing the first or last element of an already sorted list as a pivot makes quicksort perform much like insertion sort, 
        which results in a worst-case performance of O(n2).
      - To solve this, we use the "median-of-three pivot selection strategy"

    *Median-Of-Three Strategy
      - In this strategy, you find the median of the first, middle and last element in the list and use that as a pivot (NB. the median will end up at index center of the whole list). 
        This selection strategy prevents you from picking the highest or lowest element in the list.

    *Dutch National Flag Algorithm
      - A problem with Lomuto’s and Hoare’s algorithms is that they don’t handle duplicates well.
      - A solution to handle duplicate elements is Dutch national flag partitioning.

*/

List<E> quicksortNaive<E extends Comparable<dynamic>>(
  List<E> list,
) {
  // a sorted list is one that contains one or zero elements, so return it.
  if (list.length < 2) return list;

  // pick first element as pivot
  final pivot = list[0];

  // less than pivot
  final less = list.where(
    (value) => value.compareTo(pivot) < 0,
  );

  // equal to pivot
  final equal = list.where(
    (value) => value.compareTo(pivot) == 0,
  );

  // greater than pivot
  final greater = list.where(
    (value) => value.compareTo(pivot) > 0,
  );

  return [
    ...quicksortNaive(less.toList()),
    ...equal,
    ...quicksortNaive(greater.toList()),
  ];
}

/////////////// SECOND IMPLEMENTATION - IN-PLACE SORT WITH SWAP //////////////////////////////
//

extension Swappable<E> on List<E> {
  void swap(int indexA, int indexB) {
    if (indexA == indexB) return;
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }
}

////////////////////////// Lomuto's Partitioning Algorithm & Sort Algorithm //////////////////////////
int _partitionLomuto<T extends Comparable<dynamic>>(
    List<T> list, int low, int high) {
  final pivot = list[high];

  var pivotIndex = low;
  for (int i = low; i < high; i++) {
    if (list[i].compareTo(pivot) <= 0) {
      list.swap(pivotIndex, i);
      pivotIndex += 1;
    }
  }

  list.swap(pivotIndex, high);
  return pivotIndex;
}

void quicksortLomuto<E extends Comparable<dynamic>>(
    List<E> list, int low, int high) {
  if (low >= high) return;
  final pivotIndex = _partitionLomuto(list, low, high);
  quicksortLomuto(list, low, pivotIndex - 1);
  quicksortLomuto(list, pivotIndex + 1, high);
}

////////////////////////// Hoare’s Partitioning Algorithm & Sort Algorithm ////////////////////////
int _partitionHoare<T extends Comparable<dynamic>>(
    List<T> list, int low, int high) {
  final pivot = list[low];
  var left = low - 1;
  var right = high + 1;

  while (true) {
    do {
      left += 1;
    } while (list[left].compareTo(pivot) < 0);

    do {
      right -= 1;
    } while (list[right].compareTo(pivot) > 0);

    if (left < right) {
      list.swap(left, right);
    } else {
      return right;
    }
  }
}

void quicksortHoare<E extends Comparable<dynamic>>(
    List<E> list, int low, int high) {
  if (low >= high) return;
  final leftHigh = _partitionHoare(list, low, high);
  quicksortHoare(list, low, leftHigh);
  quicksortHoare(list, leftHigh + 1, high);
}

// Median-Of-Three Pivot Picking strategy
int _medianOfThree<T extends Comparable<dynamic>>(
    List<T> list, int low, int high) {
  final center = (low + high) ~/ 2;
  if (list[low].compareTo(list[center]) > 0) {
    list.swap(low, center);
  }
  if (list[low].compareTo(list[high]) > 0) {
    list.swap(low, high);
  }
  if (list[center].compareTo(list[high]) > 0) {
    list.swap(center, high);
  }
  return center;
}

// This is based on Lomuto's algorithm
void quicksortMedian<E extends Comparable<dynamic>>(
    List<E> list, int low, int high) {
  if (low >= high) return;
  var pivotIndex = _medianOfThree(list, low, high);
  list.swap(pivotIndex, high);
  pivotIndex = _partitionLomuto(list, low, high);
  quicksortLomuto(list, low, pivotIndex - 1);
  quicksortLomuto(list, pivotIndex + 1, high);
}

////////////////////////// Dutch National Flag Partitioning Algorithm //////////////////////////

class Range {
  const Range(this.low, this.high);
  final int low;
  final int high;
}

Range _partitionDutchFlag<T extends Comparable<dynamic>>(
    List<T> list, int low, int high) {
  final pivot = list[high];
  var smaller = low;
  var equal = low;
  var larger = high;

  while (equal <= larger) {
    if (list[equal].compareTo(pivot) < 0) {
      list.swap(smaller, equal);
      smaller += 1;
      equal += 1;
    } else if (list[equal] == pivot) {
      equal += 1;
    } else {
      list.swap(equal, larger);
      larger -= 1;
    }
  }

  return Range(smaller, larger);
}

void quicksortDutchFlag<E extends Comparable<dynamic>>(
    List<E> list, int low, int high) {
  if (low >= high) return;
  final middle = _partitionDutchFlag(list, low, high);
  quicksortDutchFlag(list, low, middle.low - 1);
  quicksortDutchFlag(list, middle.high + 1, high);
}
