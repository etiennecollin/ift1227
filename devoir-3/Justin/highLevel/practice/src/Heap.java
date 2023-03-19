public class Heap {

    // attributes
    private int[] array;

    // constructor
    // n is the size of the array
    public Heap(int n) {
        this.array = new int[n];
    }

    // methods
    public int getLeftChildIndex (int index) {
        return 2 * index + 1;
    }
    public int getRightChildIndex (int index) {
        return 2 * index + 2;

    }
}
