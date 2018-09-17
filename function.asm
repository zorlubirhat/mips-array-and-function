.data
A: .word 5
B: .word 3
result: .word 0

.text
.globl main
main:
		la $s0, A			
		lw $a0, 0($s0)				# $a0 = A		
		la $s1, B			
		lw $a1, 0($s1)				# $a1 = B
		la $s2, result
		lw $a2, 0($s2)				# $a2 = result
		beq $a0, $a1, equality		# if(A == B) call equality
		bne $a0, $a1, compare		# if(A != B) call compare
		jr $ra
		
equality:
		add $t1, $a0, $a1			# add a and b
		sll $v1, $t1, 3				# then multiply by 8
		sw $v1, 0($s2)				# $v1 = result
		jr $ra
		
compare:
		slt $t0, $a0, $a1			# compare A and B
		beq $t0, $0, award			# if(A >= B) call award
		jal punish					# if(A < B) call punish
		
punish:
		sub $t2, $a0, $a1			# sub a and b
		sll $v1, $t2, 1				# then multiply 2
		sw $v1, 0($s2)				# $v1 = result
		jr $ra
		
award:
		add $t2, $a0, $a1			# add a and b
		sll $v1, $t2, 2				# then multiply by 4
		sw $v1, 0($s2)				# $v1 = result
		jr $ra