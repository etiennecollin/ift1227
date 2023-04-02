/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package heapsort;

/**
 * @author Lena
 */
public class HeapSorter {
    private final int[] array;

    public HeapSorter(int[] anArray) {
        array = anArray;
    }

    public void sort() {
        int n = array.length - 1;

        // Build heap
        for (int i = (n - 1) / 2; i >= 0; i--) {
            fixHeap(i, n);
            System.out.print("FIX");
            print();
        }

        // sort
        while (n > 0) {
            swap(0, n);
            n--;
            fixHeap(0, n);
        }
        print();
    }

    private void print() {
        System.out.print("[");
        for (int e : array) {
            System.out.print(e + ", ");
        }
        System.out.println("]");
    }

    private void fixHeap(int rootIndex, int lastIndex) {
        // Remove root
        int rootValue = array[rootIndex];

        // Promote children while they are larger than the root
        while (true) {
            int leftChildIndex = getLeftChildIndex(rootIndex); // 2 * index + 1
            if (leftChildIndex <= lastIndex) {
                // Use right child instead if it is larger
                int rightChildIndex = getRightChildIndex(rootIndex);// 2 * index + 2

                if (rightChildIndex <= lastIndex && array[leftChildIndex] < array[rightChildIndex]) {
                    leftChildIndex = rightChildIndex;
                }

                if (array[leftChildIndex] > rootValue) {
                    // Promote child
                    array[rootIndex] = array[leftChildIndex];
                    rootIndex = leftChildIndex;
                } else {
                    // Root value is larger than both children
                    break;
                }
            } else {
                // No children
                break;
            }
        }

        // Store root value in vacant slot
        array[rootIndex] = rootValue;
    }

    private void swap(int i, int j) {
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    private static int getLeftChildIndex(int index) {
        return 2 * index + 1;
    }

    private static int getRightChildIndex(int index) {
        return 2 * index + 2;
    }
}
