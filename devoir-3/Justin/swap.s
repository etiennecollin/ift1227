# high level code
# temp = array[i]
# array[i] = array[j]
# array[j] = temp

# $a0 holds the base address of the array
# $a1 holds the index of element i
# $a2 holds the index of element j

swap:
    sll $t0, $a1, 2     # offset of element i
    add $t0, $a0, $t0   # address of element i

    sll $t1, $a0, 2     # offset of element j
    add $t1, $a0, $t1   # address of element j

    lw $t3, 0($t0)      # $t3 = array[i]
    lw $t4, 0($t1)      # $t4 = array[j]
    sw $t4, 0($t0)      # array[i] = array[j]
    sw $t3, 0($t1)      # array[j] = $t3

    jr $ra              # return


    