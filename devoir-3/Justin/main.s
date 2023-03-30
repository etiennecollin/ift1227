# heap and heapSort implemented in MIPS assembly language
# authors : Étienne Collin and Justin Villeneuve

.data
arrayStart: .word 0x10040000                        # address of first element of array
n: .word 0                                          # n = size of array (initializes at 0)
inputMsg: .asciiz "Enter the length of the array : "
arrayMsg: .asciiz "Enter an element in the array : "

.text
.globl main

main:
    jal     init

# ------------------------------------------------------------------------------
# The init function takes no parameters, initializes an array of n elements
# from address 0x10040000, and returns 2 values: the address of the created
# array and its size.
init:

# ask the user the length of the array
    li      $v0,        4                           # print a message to the user
    la      $a0,        inputMsg                    # address of the message
    syscall

# read the size of the array entered by the user
    li      $v0,        5                           # read an integer
    syscall
    move    $s0,        $v0                         # $s0 holds the size of the array

# Initialiser les éléments du tableau
    li      $t0,        0                           # ctr initialized to 0
    la      $t1,        arrayStart                  # address of first element of array
    add     $t2,        $t1,        $s0             # address of last element of array

initLoop:
    beq     $t0,        $s0,        initExit        # verify if ctr reached the end of the array

# ask user of input
    li      $v0,        4                           # print a string
    la      $a0,        arrayMsg                    # adresse du message de demande
    move    $a1,        $t0                         # numéro de l'élément actuel du tableau
    syscall

# Lire la valeur de l'élément actuel du tableau saisie par l'utilisateur
    li      $v0,        5                           # lire un entier
    syscall
    sw      $v0,        ($t1)                       # stocker la valeur de l'élément dans le tableau
    addi    $t0,        $t0,        1               # incrémenter le compteur
    addi    $t1,        $t1,        4               # passer à l'élément suivant du tableau
    j       initLoop

initExit:
                                                    # terminate
    li      $v0,        10                          # terminate execution
    syscall
