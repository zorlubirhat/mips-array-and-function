.data
sizeofarray: .word 3
array: .word 2, 4, 6, 8

.text
.globl main
main:
		la $s0, sizeofarray			
		lw $s1, 0($s0)			#$s1 = sizeofarray
		ori $s2, $0, 0			#$s2 = i
		la $s3, array			#$s3 = &array
		
loopFor:
		beq $s1, $s2, funcExit	#if(i = sizeofarray) call funcExit 
		lw $s4, 0($s3)			#$s4 = array[i]
		lw $s5, 4($s3)			#$s5 = array[i+1]
		sub $t5, $s5, $s4		#$t5 = diff
		blez $t5, negFunc		#if(diff <= 0) call negFunc
		bgtz $t5, posFunc		#if(diff > 0) call posFunc
		j update				#call function for i++
		
negFunc:
		bgtz $t5, update		#call function for i++
		sll $t2, $s4, 2			#multiply by 4
		sll $t3, $s4, 0			#multiply by 1
		add $t3, $t2, $t3		#add mult. by 1 and mult. by 4
		sub $t4, $0, $t3		#negative of result
		sw $t4, 4($s3)			#array[i+1] = result(*-5)
		j update
posFunc:
		bltz $t5, update		#call function for i++
		sll $t2, $s4, 2			#multiply by 4
		sll $t3, $s4, 0			#multiply by 1
		add $t4, $t2, $t3		#add mult. by 1 and mult. by 4
		sw $t4, 0($s3)			#array[i] = result (*5)
		j update
update:
		addi $s2, $s2, 1		#i++
		addi $s3, $s3, 4		#move array pointer
		j loopFor			
		
funcExit:
		jr $ra 