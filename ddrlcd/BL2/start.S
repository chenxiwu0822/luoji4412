.text
.globl _start
_start:

      // �رտ��Ź�
      ldr	r0, =0x10060000
      mov	r1, #0
      str	r1, [r0]
      
      // ��icache����������ٶ�
      mrc	p15, 0, r0, c1, c0, 0
      //orr	r0, r0, #0x00001000      //��ICache
      //bic	r0, r0, #0x00001000      //�ر�ICache
      mcr	p15, 0, r0, c1, c0, 0
       
      ldr sp, =0x02027800 // ����C����֮ǰ��������ջ,ջ���ڱ������л���,���ֲ���������ռ�
                        // �ο�ROM�ֲ�P14, ���ǰ�ջָ��BL2�Ϸ�1K��(1K�Ѿ�����),
                        // ��:0x02020000 (iRAM����ַ) + 5K(iROM������) + 8K(BL1��) + 16K(BL2��) + 1K(����ջ))
      bl system_clock_init // ����ʱ�ӳ�ʼ������
      
      //bl uart_asm_init  /* init uart for debug */
      
      bl mem_init     //��ʼ��DDR SDRAM
      
      bl copy_code_to_dram     //�ض�λ��������DRAM������
	

halt:
	b halt