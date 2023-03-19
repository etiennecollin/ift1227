# returns the indice of the left child in the data structure called "heap".
# the left child node of the node with index i has index 2i + 1

# int getLeftChildIndex(int index)
# {
#  return 2 * index + 1;
# }


# $a0 = index
getLeftChildIndex:
    sll $a0, $a0, 1       # 2 * index
    addi $v0, $a0, 1     # 2 * i + 1
    jr $ra              # return
