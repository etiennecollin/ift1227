/*
 * To change this license header, choose License Headers in Project Properties. To change this
 * template file, choose Tools | Templates and open the template in the editor.
 */

package heapsort;

/**
 *
 * @author Lena
 */
public class HeapSort {

    private int[] array;

    public HeapSort(int[] anArray) {
        array = anArray;
    }

    public void sort() {
        int n = array.length - 1;

        for (int i = (n - 1) / 2; i >= 0; i--) {
            fixHeap(i, n);
        }

        while (n > 0) {
            swap(0, n);
            n--;
            fixHeap(0, n);
        }
    }

    private void fixHeap(int rootIndex, int lastIndex) {
        // Remove root
        int rootValue = array[rootIndex];

        // Promote children while they are larger than the root
        int index = rootIndex;
        boolean more = true;

        while (more) {
            int childIndex = getLeftChildIndex(index); // 2 * index + 1

            if (childIndex <= lastIndex) {
                // Use right child instead if it is larger
                int rightChildIndex = getRightChildIndex(index);// 2 * index + 2

                if (rightChildIndex <= lastIndex && array[rightChildIndex] > array[childIndex]) {
                    childIndex = rightChildIndex;
                }

                if (array[childIndex] > rootValue) {
                    // Promote child
                    array[index] = array[childIndex];
                    index = childIndex;
                } else {
                    // Root value is larger than both children
                    more = false;
                }
            } else {
                // No children
                more = false;
            }
        }

        // Store root value in vacant slot
        array[index] = rootValue;
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
