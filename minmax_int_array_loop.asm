.data
   myarray: .space 40    
   mes: .asciiz "Please enter the 10 integers\n"
   maxInt:  .asciiz "Your Max: \n"
   max:     .word 0
   minInt:  .asciiz "\nYour Min: \n"
   min:     .word 0
   newLine: .asciiz "\n"
   
.text
   li $v0,4
   la $a0,mes
   syscall
   
   li $s0,0
   
   loop:
     li $v0,5
     syscall
     
     sw $v0,myarray($t0)
     add $t0,$t0,4
     add $s0,$s0,1
     blt $s0,10,loop
         
     li $t0,0
     lw $s0,myarray($t0)
     li $t1,1
     
   fun:
     beq $t1,10 new
     add $t0,$t0,4
     lw $s1,myarray($t0)
     bge $s0,$s1,pause
     move $s0,$s1
     
   pause:
     add $t1,$t1,1
     j fun
   
   new:
     beq $t1,10 exit
     add $t0,$t0,4
     lw $s1,myarray($t0)
     blt $s2,$s1,replace
     move $s2,$s1 
     
   replace:
     add $t1,$t1,1
     j new         
     
   exit:
     li $v0,4
     la $a0,maxInt
     syscall
     
     li $v0,1
     move $a0,$s0
     syscall
     sw $s0,max

     li $v0,4
     la $a0,minInt
     syscall
     
     li $v0,1
     move $a0,$s2
     syscall
     sw $s2,min
     
     #exit
     li $v0,10
     syscall