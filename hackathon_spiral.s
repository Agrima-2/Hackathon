AREA     circle, CODE, READONLY
     EXPORT __main
	 IMPORT printMsg
     ENTRY 
__main  FUNCTION
		VLDR.F32 S13, =0.5 
		VLDR.F32 S0, =0.01746 ;Value of theta
		VLDR.F32 S7, =20 ;
		MOV R10,#1
		VLDR.F32 S8, =1
		VMOV.F32 S15,S0
 
next_Value		BL Sin
		BL Cos
		
		VLDR.F32 S21, =50           // X centre 
		VADD.F32 S11,S11,S21
		VCVT.U32.F32 S11,S11
		VMOV R0,S11
		;BL printMsg
		
		
		VLDR.F32 S22, =50	// Y centre 
		VADD.F32 S12,S12,S22
		VCVT.U32.F32 S12,S12
		VMOV R1,S12
		
		MOV R2, #20
		MOV R3, #0
		BL printMsg
		
		
		VADD.F32 S10,S10,S8
		VMUL.F32 S15,S15,S10
		ADD R10,R10,#1
		CMP R10, #270
		BNE next_Value
			
;------------------------------------------------------------------------------------

next_value2	VSUB.F32 S3,S3,S13
	BL Sin
		BL Cos
		
		VLDR.F32 S21, =50           // X centre 
		VADD.F32 S11,S11,S21
		VCVT.U32.F32 S11,S11
		VMOV R0,S11
		;BL printMsg
		
		
		VLDR.F32 S22, =50	// Y centre 
		VADD.F32 S12,S12,S22
		VCVT.U32.F32 S12,S12
		VMOV R1,S12
		
		MOV R2, #20
		MOV R3, #0
		BL printMsg
		
		
		VADD.F32 S10,S10,S8
		VMUL.F32 S15,S15,S10
		ADD R10,R10,#1
		CMP R10, #270
		BNE next_Value2




;---------------------------------------------------------------------------------------
		
		;Second Spiral
		

VLDR.F32 S0, =0.01746 ;Value of theta
		VLDR.F32 S7, =13;
		MOV R10,#1
		VLDR.F32 S8, =1
		VMOV.F32 S15,S0
 
next_Value1		BL Sin
		BL Cos
		
		VLDR.F32 S21, =115         // X centre 
		VADD.F32 S11,S11,S21
		VCVT.U32.F32 S11,S11
		VMOV R0,S11
		;BL printMsg
		
		
		VLDR.F32 S22, =115	// Y centre 
		VADD.F32 S12,S12,S22
		VCVT.U32.F32 S12,S12
		VMOV R1,S12
		
		MOV R2, #20
		MOV R3, #0
		BL printMsg
		
		
		VADD.F32 S10,S10,S8
		VMUL.F32 S15,S15,S10
		ADD R10,R10,#1
		CMP R10, #270
		BNE next_Value1


;----------------------------------------------------------------------------------------
next_value3	VSUB.F32 S3,S3,S13

		BL Sin
		BL Cos
		
		VLDR.F32 S21, =115         // X centre 
		VADD.F32 S11,S11,S21
		VCVT.U32.F32 S11,S11
		VMOV R0,S11
		;BL printMsg
		
		
		VLDR.F32 S22, =115	// Y centre 
		VADD.F32 S12,S12,S22
		VCVT.U32.F32 S12,S12
		VMOV R1,S12
		
		MOV R2, #20
		MOV R3, #0
		BL printMsg
		
		
		VADD.F32 S10,S10,S8
		VMUL.F32 S15,S15,S10
		ADD R10,R10,#1
		CMP R10, #270
		BNE next_Value3

		B stop


;-----------------------------------------------------------------------------------------






;sinA
		;Calculating sin(A)			
Sin		MOV R0,#1
		MOV R1,#2 ;Using R0,R1,R2 for calculating the factorial for every term
		MOV R2,#3
		MOV R3,#0
		VLDR.F32 S3, =0
		
		VMOV.F32 S0,S15
		VLDR.F32 S15, =0.01746
		
		VLDR.F32 S1, =1
		VMUL.F32 S2,S0,S0
		
sin_loop	VDIV.F32 S0,S0,S1
		VADD.F32 S3,S3,S0
		VMUL.F32 S0,S2,S0 ;Calculating each term of sin series
		MUL R0,R1,R2 ;Calculating factorial
		ADD R1,R1,#2 ;Adding 2 for calculating next term factorial
		ADD R2,R2,#2 ;Adding 2 for calculating next term factorial
		VNEG.F32 S0,S0 ;Negating the alternate term of series
		VMOV.F32 S1, R0 ;Moving the value of register R0 to floating register S1
		VCVT.F32.U32 S1,S1 ;Converting the value of S1 from exponential form to floating point number
		ADD R3,R3,#1 ;Incrementing the counter
		CMP R3,#10 ;Comparing the counter value
		BNE sin_loop
		VMOV.F32 S11,S7
		VMUL.F32 S11,S11,S3 ;x=r*sinA
		
		;VCVT.U32.F32 S11,S11
		;VMOV R11,S11
		BX LR
		
		
;cosA
		;Calculating cos(A)
Cos		MOV R4, #3;
		MOV R5, #4;
		VLDR.F32 S4, =1;
		VMOV.F32 S9, S2;
		VNEG.F32 S9,S9;
		VMOV.F32 S5,S9;
		VLDR.F32 S1, =2;
		MOV R3,#0;
		
cos_loop	VDIV.F32 S5,S5,S1;
		VADD.F32 S4,S4,S5;
		VMUL.F32 S5,S5,S2;
		MUL R0,R4,R5;
		VMOV.F32 S1, R0;
		VCVT.F32.U32 S1,S1;
		VNEG.F32 S5,S5;
		ADD R4,R4,#2;
		ADD R5,R5,#2;
		ADD R3,R3,#1;
		CMP R3,#10;
		BNE cos_loop
		VMOV.F32 S12,S7
		VMUL.F32 S12,S12,S4 ;y=r*cosA
		
		;VCVT.U32.F32 S12,S12
		;VMOV R12,S12
		BX LR

		
stop    B stop ; stop program?
	ENDFUNC
	END 