/*
 * To change this license header, choose License Headers in Project Properties. To change this
 * template file, choose Tools | Templates and open the template in the editor.
 */

package heapsort;

/**
 *
 * @author Lena
 */
public class HeapSortInitializer {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int[] array = new int[10];
        array[0] = 56;
        array[1] = 2;
        array[3] = -78;
        array[4] = 100;
        array[5] = 42;
        array[6] = 0;
        array[7] = 99;
        array[8] = -23;
        array[9] = 17;

        HeapSort sorter = new HeapSort(array);
        sorter.sort();

        for (int value : array)
            System.out.println(value);

    }
}
