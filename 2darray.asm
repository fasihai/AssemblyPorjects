.data
  table: .word 5, 3, 2, 4
         .word 51, 31, 21, 41
         .word 55, 33, 22, 44
         .word 15, 13, 12, 14
  prompt: .asciiz "Pick a row and colomn # between 0-3 to see the value of the element\n\n"
  mess1: .asciiz "Please pick a row #\n"
  mess2: .asciiz "\nPlease pick a colomn #\n"
  mess3: .asciiz "\nThe value in the element with the row# and colomn# you picked is: \n"
  mess4: .asciiz "\nThe # you picked is not between 0-3. Program ending, goodbye\n"
  newLine: .asciiz "\n\n"
.text
  
  li $v0, 4
  la $a0, prompt
  syscall
   
  loop:
  
    li $v0, 4
    la $a0, mess1
    syscall
  
    li $v0, 5
    syscall
    
    move $t0, $v0
    bgt $t0, 3, exit
    
    li $v0, 4
    la $a0, mess2
    syscall
  
    li $v0, 5
    syscall
    
    move $t1, $v0
    bgt $t1, 3, exit
    
    la $a1, table
    jal offset
    li $v0, 4
    la $a0, mess3
    syscall

    move $a0, $s2    
    li $v0, 1
    syscall
    
    li $v0, 4
    la $a0, newLine
    syscall 
       
    j loop
    
  exit:
  
    li $v0, 4
    la $a0, mess4
    syscall
    
    li $v0, 10
    syscall
  
  offset:
    mul $t2, $t0, 4
    add $t2, $t2, $t1
    mul $t2, $t2, 4
    add $s2, $t2, $a1 
    lw $s2, 0 ($s2)

    
    
 jr $ra
    
    