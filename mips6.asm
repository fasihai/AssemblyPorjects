.data 
 myarray: .space 40
 mess: .asciiz "Please enter 10 numbers.\n"
 answer: .asciiz "The numbers you ordered in order are: \n"
 newLine: .asciiz "\n"
 switch: .asciiz "Your numbers in reverse: \n"
 
.text

 addi $t0, $zero, 0
 addi $t3, $zero, 0 
 la $s0, myarray
 li $v0, 4
 la $a0, mess 
 syscall
 
  fun:
  
   beq $t0, 10, list
   add $v0, $zero, 5 
   syscall
   
   add $t1, $v0, $zero
   sll $t2, $t0, 2 
   add $t2, $t2, $s0
   
   sw $t1, ($t2)
   addi $t0, $t0, 1
   b fun 
   
  list:
  
   addi $t0, $zero, 0 
   addi $t2, $zero, 0 
   li $v0, 4
   la $a0, answer 
   syscall
   
   jal printList
   
  printList:
  
   beq $t0, 10, reverse
   sll $t2, $t0, 2 
   add $t2, $t2, $s0 
   lw $t1, ($t2)
   la $v0, 1
   la $a0, ($t1) 
   syscall
   
   subu $sp, $sp, 4
   sw $t1, ($sp)
   
   la $v0, 4
   la $a0, newLine 
   syscall
   
   addi $t0, $t0, 1
   b printList 
   
  reverse:
   
   li $v0, 4
   la $a0, switch 
   syscall
   
   lw $a0, ($sp)
   li $v0, 1
   syscall
   jal pop

  pop:
  
   beq $t3, 9, exit
 
   li $v0, 4
   la $a0, newLine 
   syscall
   
   addu $sp, $sp, 4 
   lw $a0, ($sp)
   li $v0, 1
   syscall
   
   add $t3, $t3, 1
   b pop
  
exit:
  
 li $v0, 10 
 syscall