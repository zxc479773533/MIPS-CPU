.text
  addi $s1,$zero,32   
  addi $v0,$zero,34         # display hex
  j jmp_next1               # j instruction  
  addi $s1,$zero, 0
  addi $s1,$zero, 0
  addi $v0,$zero, 10
jmp_next1:beq $zero,$zero jmp_next2  # beq instruction 
  addi $s1,$zero, 0
  addi $s1,$zero, 0
  addi $v0,$zero, 10
jmp_next2:bne $zero,$s1,jmp_next3    # bne instruction 
  addi $s1,$zero, 0
  addi $s1,$zero, 0
  addi $v0,$zero, 10
jmp_next3: jal jmp_func     # jal instruction   
  addi $v0,$zero,10         # system call for exit
  nop                       # bubbles for data hazard
  nop
  nop
  syscall                   # we are out of here.   
jmp_func: 
  addi $s1,$s1,-1
  nop
  nop
  nop
  add $a0,$0,$s1       
  nop
  nop
  nop
  syscall        
  bne $s1,$zero,jmp_func    # loop   
  jr $31                    # jr  instruction 
