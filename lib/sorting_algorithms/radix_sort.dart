import 'dart:math';

void main() {
  //
  var mainList = [11, 90, 67, 22, 9, 2];
  var myList = [
    [23],
    [7, 2],
    [45],
    [3],
    [1]
  ];

  var a = myList.expand((item) => item);

  print("Original: $myList");
  print("Expanded Result: $a\n");
  print("Main List: $mainList");
  mainList.radixSort();
  print("Radix Sorted List: $mainList");

  print(8990.digitAt(1)); // testing

  final listMSD = [46, 500, 459, 1345, 13, 999];
  print("Main MSD List: $mainList");
  listMSD.lexicographicalSort();
  print("Sorted MSD List: $mainList");
  print(listMSD);
}

/*
    Radix Sort:
      The word radix means base (like a number system).
      Radix sort is a non- comparative algorithm for sorting integers

    NB:
      1. You can use any base with a radix sort, but we will be using base10
      2. We have the Least Significant Digit (LSD) & Most Significant Digit (MSD), according to the place vallue of that paticular number.
      3. We have LSD-radix sort and MSD-radix sort - MSD-radix sort uses the most significant digit to sort a list while LSD-radix sort uses the least significant digit to sort a list.
      4. Radix sort is one of the fastest sorting algorithms

    NB: The average time complexity of this LSD-radix sort is O(k × n), where k is the number of significant digits in the largest number, and n is the number of integers in the list.

    How Radix Sort Works: 
      Unlike the other sorting algorithms you’ve implemented in previous chapters, radix sort doesn’t rely on comparing two values. 
      It leverages bucket sort, which is a way to sort numbers by their digits.

    MSD & LSD:
      1. Least-Significant-Digit (LSD) radix sort begins sorting with the right-most digit.
      2. Most-Significant-Digit (MSD) sorts by prioritizing the left-most digits over the lesser ones to the right.

*/

extension RadixSort on List<int> {
  void radixSort() {
    const base = 10;
    var done = false;

    var place = 1;
    while (!done) {
      done = true;

      final buckets = List.generate(base, (_) => <int>[]);
      forEach((number) {
        final remainingPart = number ~/ place;
        final digit = remainingPart % base;

        buckets[digit].add(number);
        if (remainingPart ~/ base > 0) {
          done = false;
        }
      });

      place *= base;
      clear();
      addAll(buckets.expand((element) => element));
    }
  }
}

////// SOME HELPER FOR MSD RADIX SORT  /////////////
extension Digits on int {
  static const _base = 10;

  // counts the digits in a particular integer
  int digits() {
    var count = 0;
    var number = this;
    while (number != 0) {
      count += 1;
      number ~/= _base;
    }
    return count;
  }

  // This finds the index or place value of a particular digit in an integer
  int? digitAt(int position) {
    if (position >= digits()) {
      return null;
    }
    var number = this;
    while (number ~/ pow(_base, position + 1) != 0) {
      number ~/= _base;
    }

    return number % _base;
  }
}

extension MsdRadixSort on List<int> {
  // Given a list of int. This counts the digits in the largest number in the list
  int maxDigits() {
    if (isEmpty) return 0;
    return reduce(max).digits();
  }

  void lexicographicalSort() {
    final sorted = _msdRadixSorted(this, 0);
    clear();
    addAll(sorted);
  }

  List<int> _msdRadixSorted(List<int> list, int position) {
    if (list.length < 2 || position >= list.maxDigits()) {
      return list;
    }

    final buckets = List.generate(10, (_) => <int>[]);

    var priorityBucket = <int>[];

    for (var number in list) {
      final digit = number.digitAt(position);
      if (digit == null) {
        priorityBucket.add(number);
        continue;
      }
      buckets[digit].add(number);
    }

    final bucketOrder = buckets.reduce((result, bucket) {
      if (bucket.isEmpty) return result;

      final sorted = _msdRadixSorted(bucket, position + 1);
      return result..addAll(sorted);
    });

    return priorityBucket..addAll(bucketOrder);
  }
}
