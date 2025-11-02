.data
vars: .word 0
.text
la $t0, vars
lw $t1, 0($t0)
li $t2, 3
saut: beq $t1, $t2, exit
move $a0, $t1
li $v0, 1
addi $t1, $t1, 1
j saut
exit: li $v0, 10
syscall