# NOTES ::::::::


## Data Structures (DS)
The study of DS is for efficiency - given a particular amount of data, what is the best way to store it to achieve a particular goal.

## Scalability of Algorithms
For algorithms, scalability refers to how the algorithm performs in terms of execution time and memory usage as the input size increases.

## Time Complexity
Time complexity is a measure of the time required to run an algorithm as the input size increases.

## Space Complexity
The neasure of the memory allocation needed for an algorithm as input size increases.

## Inserting Item in a LIST
If the number of elements in the list doubles, the time required for this insert operation will also double. (Adding item at the end of a list is less-costly)
    - Inserting a new item to a list that is out of room (growable list): 
      A copy is made and a bigger storage is allocated for the growable array.
    - Dart employs a strategy that minimizes the times this copying needs to occur. Each time it runs out of storage and needs to copy, it doubles the capacity.


## Map
  - Default Dart Implementation uses LinkedHashMap which promises to maintain insertion order, unlike HashMap.
  - Adding and removing of items is in constant time O(1)


## Sets
  - Dart’s default implementation of Set uses LinkedHashSet, which, unlike HashSet, promises to maintain insertion order.


## Stacks