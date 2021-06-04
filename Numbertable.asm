.data
   table:  .word 50, 30, 20, 40
           .word 51, 31, 21, 41 
           .word 52, 32, 22, 42 
           .word 53, 54, 55, 56          
   mes1:   .asciiz "\nRow #: "
   maxInt: .asciiz "\nMax: "
   mes2:   .asciiz "\nColumn #: "
   row:    .word 0
   column: .word 0
   h:      .word 3
   l:      .word 3
   newmatrix:.asciiz "\nNew table is: \n"
   space:  .asciiz " "
   newline:.asciiz "\n"
   
.text 
   start:
      lw $t0, row
      lw $t1, column 
      lw $t2, h
      lw $t3, l
      li $s1, 0
      li $s2, 0
      la $a1, table
      jal oldarray
    oldarray:
     bgt $t0, $t2, first
     jal offset
     b oldarray 
    first:
     li $t0, 0 
     li $t1, 0 
     li $s1, 0 
     li $s2, 0 
     li $s5, 0 
     li $s6, 0
     
     li $v0, 4
     la $a0, newmatrix 
     syscall
     jal newarray
     
    newarray:
    
     bgt $t0, $t2, exit
     jal loop
     b newarray
      
    exit: 
    
     li $v0, 10
     syscall
     
    offset:
     bgt $t1, $t3, next
     mul $s1, $t0, 4 
     add $s1, $s1, $t1 
     mul $s1, $s1, 4 
     add $s2, $s1, $a1 
     lw $s2, 0($s2)
     li $v0, 1
     move $a0, $s2 
     syscall
     li $v0, 4
     la $a0, space 
     syscall
     add $t1, $t1, 1
     j offset
    next:
     li $t1, 0
     add $t0, $t0, 1
     li $v0, 4
     la $a0, newline 
     syscall
     j oldarray
    loop:
     bgt $t1, $t3, nextafter
     bne $t0, $t1, firsttable 
     j newdiag
    nextafter:
     li $t1, 0
     add $t0, $t0, 1
     li $v0, 4
     la $a0, newline 
     syscall
     j newarray
    newdiag:
     mul $s5, $t0, 4 
     add $s5, $s5, $t1 
     mul $s5, $s5, 4 
     add $s6, $s5, $a1 
     lw $s6, 0($s6) 
     mul $s6, $s6, 2
     li $v0, 1
     move $a0, $s6 
     syscall
     li $v0, 4
     la $a0, space
     syscall
     add $t1, $t1, 1 
     j loop
    firsttable:
     mul $s1, $t0, 4 
     add $s1, $s1, $t1 
     mul $s1, $s1, 4 
     add $s2, $s1, $a1 
     lw $s2, 0($s2)
     li $v0, 1
     move $a0, $s2 
     syscall
     li $v0, 4
     la $a0, space 
     syscall
     add $t1, $t1, 1 
     j newarray
