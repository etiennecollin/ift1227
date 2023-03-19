# returns the indice of the right child in the data structure called "heap".
# the right child node of the node with index i has index 2i + 2

# $a0 = index
getRightChildIndex:
    sll $a0, $a0, 1       # 2 * index
    addi $v0, $a0, 2     # 2 * i + 2
    jr $ra              # return