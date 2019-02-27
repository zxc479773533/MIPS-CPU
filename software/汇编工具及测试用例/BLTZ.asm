#bltz ����    С��0��ת   �ۼ����㣬�Ӹ�����ʼ�������� revise date:2018/3/12 tiger  
#�������0xfffffff1 0xfffffff2 0xfffffff3 0xfffffff4 0xfffffff5 0xfffffff6 0xfffffff7 0xfffffff8 0xfffffff9 0xfffffffa 0xfffffffb 0xfffffffc 0xfffffffd 0xfffffffe 0xffffffff
.text
addi $s1,$zero,-15       #��ʼֵ
bltz_branch:
add $a0,$0,$s1          
addi $v0,$zero,34         
syscall                  #�����ǰֵ
addi $s1,$s1,1 
bltz $s1,bltz_branch     #��ǰָ��


addi   $v0,$zero,10    
syscall                  #��ͣ���˳�
