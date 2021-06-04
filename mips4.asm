.data 
message1: .asciiz "Hello, what is your name?\n"
input: .space 20
message2: .asciiz "\nYou entered "
message3: .asciiz "\nHow many hours did you work this week?\n"
message4: .asciiz "\n\nWhat is your hourly rate?\n"
message5: .asciiz "\n\nYour pay check this week for "
message6: .asciiz "is "

.text

li $v0, 4
la $a0, message1
syscall

li $v0, 8
la $a0, input
la $a1, 20
syscall

li $v0, 4
la $a0, message2
syscall
li $v0, 4
la $a0, input
syscall
la $a0, message3
syscall

li $v0, 5
syscall
move $t0, $v0

li $v0, 4
la $a0, message2
syscall

li $v0, 1
move $a0, $t0
syscall

li $v0, 4
la $a0, message4
syscall

li $v0, 5
syscall
move $t1, $v0

li $v0, 4
la $a0, message2
syscall

li $v0, 1
move $a0, $t1
syscall

li $v0, 4
la $a0, message5
syscall
la $a0, input
syscall
la $a0, message6
syscall

mul $t2,$t0,$t1

li $v0,1
add $a0, $zero, $t2
syscall

#Exit
li $v0, 10
syscall