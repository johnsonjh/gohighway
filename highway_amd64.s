// +build !noasm
// Generated by PeachPy 0.2.0 from sum.py

// func hashSSE(keys uintptr, init0 uintptr, init1 uintptr, p_base uintptr, p_len int64, p_cap int64) uint64
TEXT ·hashSSE(SB), 4, $0-56
	MOVQ   keys+0(FP), AX
	MOVQ   init0+8(FP), BX
	MOVQ   init1+16(FP), CX
	MOVOU  0(AX), X0
	MOVOU  16(AX), X1
	MOVOU  0(BX), X2
	MOVOU  16(BX), X3
	MOVOU  0(CX), X4
	MOVOU  16(CX), X5
	PSHUFL $177, X1, X6
	PSHUFL $177, X0, X7
	PXOR   X2, X0
	PXOR   X3, X1
	PXOR   X4, X7
	PXOR   X5, X6
	MOVQ   p_base+24(FP), AX
	MOVQ   p_len+32(FP), BX
	CMPQ   BX, $32
	JLT    loop1_end

loop1_begin:
	MOVOU   0(AX), X8
	MOVOU   16(AX), X9
	PADDQ   X8, X7
	PADDQ   X9, X6
	PADDQ   X2, X7
	PADDQ   X3, X6
	MOVO    X0, X8
	MOVO    X1, X9
	MOVO    X7, X10
	MOVO    X6, X11
	PSRLQ   $32, X8
	PSRLQ   $32, X9
	PMULULQ X8, X10
	PMULULQ X9, X11
	PXOR    X10, X2
	PXOR    X11, X3
	PADDQ   X4, X0
	PADDQ   X5, X1
	MOVO    X7, X8
	MOVO    X6, X9
	MOVO    X0, X10
	MOVO    X1, X11
	PSRLQ   $32, X8
	PSRLQ   $32, X9
	PMULULQ X8, X10
	PMULULQ X9, X11
	PXOR    X10, X4
	PXOR    X11, X5
	MOVQ    $4223284375849987, CX
	MOVQ    CX, X8
	MOVQ    $506661594022413323, CX
	MOVQ    CX, X9
	MOVLHPS X9, X8
	MOVO    X7, X10
	PSHUFB  X8, X10
	MOVO    X6, X11
	PSHUFB  X8, X11
	PADDQ   X10, X0
	PADDQ   X11, X1
	MOVO    X0, X10
	PSHUFB  X8, X10
	MOVO    X1, X11
	PSHUFB  X8, X11
	PADDQ   X10, X7
	PADDQ   X11, X6
	ADDQ    $32, AX
	SUBQ    $32, BX
	CMPQ    BX, $32
	JGE     loop1_begin

loop1_end:
	CMPQ   BX, $0
	JEQ    finalize
	MOVQ   BX, CX
	SHLQ   $32, CX
	ADDQ   BX, CX
	MOVQ   CX, X8
	PINSRQ $1, CX, X8
	PADDQ  X8, X0
	PADDQ  X8, X1
	MOVQ   BX, CX
	MOVO   X7, X8
	MOVQ   CX, X9
	PSLLL  X9, X8
	SUBQ   $32, CX
	NEGQ   CX
	MOVQ   CX, X9
	PSRLL  X9, X7
	POR    X8, X7
	MOVQ   BX, CX
	MOVO   X6, X8
	MOVQ   CX, X9
	PSLLL  X9, X8
	SUBQ   $32, CX
	NEGQ   CX
	MOVQ   CX, X9
	PSRLL  X9, X6
	POR    X8, X6
	MOVQ   BX, CX
	ANDQ   $3, CX
	NEGQ   CX
	ADDQ   BX, CX
	MOVQ   AX, DX
	PXOR   X8, X8
	PXOR   X9, X9
	CMPQ   CX, $0
	JEQ    memcpy32_fin
	CMPQ   CX, $16
	JLT    memcpy32_skipLoad16
	MOVOU  0(AX), X8
	ADDQ   $16, AX
	SUBQ   $16, CX
	XORQ   DI, DI
	CMPQ   CX, $8
	JLT    skip81
	MOVQ   0(AX), SI
	MOVQ   SI, X9
	SUBQ   $8, CX
	ADDQ   $8, AX
	MOVQ   $1, DI

skip81:
	XORQ    SI, SI
	CMPQ    CX, $0
	JEQ     __local3
	CMPQ    CX, $1
	JEQ     __local5
	CMPQ    CX, $2
	JEQ     __local13
	CMPQ    CX, $3
	JEQ     __local11
	CMPQ    CX, $4
	JEQ     __local4
	CMPQ    CX, $5
	JEQ     __local1
	CMPQ    CX, $6
	JEQ     __local15
	MOVBQZX 6(AX), CX
	SHLQ    $48, CX
	ORQ     CX, SI

__local15:
	MOVBQZX 5(AX), CX
	SHLQ    $40, CX
	ORQ     CX, SI

__local1:
	MOVBQZX 4(AX), CX
	SHLQ    $32, CX
	ORQ     CX, SI

__local4:
	MOVBQZX 3(AX), CX
	SHLQ    $24, CX
	ORQ     CX, SI

__local11:
	MOVBQZX 2(AX), CX
	SHLQ    $16, CX
	ORQ     CX, SI

__local13:
	MOVBQZX 1(AX), CX
	SHLQ    $8, CX
	ORQ     CX, SI

__local5:
	MOVBQZX 0(AX), CX
	SHLQ    $0, CX
	ORQ     CX, SI
	CMPQ    DI, $1
	JEQ     insert11
	PINSRQ  $0, SI, X9
	JMP     fin161

insert11:
	PINSRQ $1, SI, X9

fin161:
__local3:
	JMP memcpy32_fin

memcpy32_skipLoad16:
	XORQ DI, DI
	CMPQ CX, $8
	JLT  skip80
	MOVQ 0(AX), SI
	MOVQ SI, X8
	SUBQ $8, CX
	ADDQ $8, AX
	MOVQ $1, DI

skip80:
	XORQ    SI, SI
	CMPQ    CX, $0
	JEQ     __local2
	CMPQ    CX, $1
	JEQ     __local12
	CMPQ    CX, $2
	JEQ     __local10
	CMPQ    CX, $3
	JEQ     __local9
	CMPQ    CX, $4
	JEQ     __local8
	CMPQ    CX, $5
	JEQ     __local7
	CMPQ    CX, $6
	JEQ     __local6
	MOVBQZX 6(AX), CX
	SHLQ    $48, CX
	ORQ     CX, SI

__local6:
	MOVBQZX 5(AX), CX
	SHLQ    $40, CX
	ORQ     CX, SI

__local7:
	MOVBQZX 4(AX), CX
	SHLQ    $32, CX
	ORQ     CX, SI

__local8:
	MOVBQZX 3(AX), CX
	SHLQ    $24, CX
	ORQ     CX, SI

__local9:
	MOVBQZX 2(AX), CX
	SHLQ    $16, CX
	ORQ     CX, SI

__local10:
	MOVBQZX 1(AX), CX
	SHLQ    $8, CX
	ORQ     CX, SI

__local12:
	MOVBQZX 0(AX), CX
	SHLQ    $0, CX
	ORQ     CX, SI
	CMPQ    DI, $1
	JEQ     insert10
	PINSRQ  $0, SI, X8
	JMP     fin160

insert10:
	PINSRQ $1, SI, X8

fin160:
__local2:
memcpy32_fin:
	CMPQ   BX, $16
	JLT    mod4check
	ADDQ   BX, DX
	SUBQ   $4, DX
	MOVL   0(DX), AX
	PINSRD $3, AX, X9
	JMP    afterMod4

mod4check:
	MOVQ    BX, CX
	ANDQ    $3, CX
	NEGQ    CX
	ADDQ    BX, CX
	ADDQ    CX, DX
	MOVQ    BX, AX
	ANDQ    $3, AX
	JEQ     afterMod4
	XORQ    BX, BX
	MOVBQZX 0(DX), BX
	MOVQ    AX, CX
	SHRQ    $1, CX
	MOVQ    DX, DI
	ADDQ    CX, DI
	MOVBQZX 0(DI), CX
	SHLQ    $8, CX
	ORQ     CX, BX
	MOVQ    AX, CX
	SUBQ    $1, CX
	MOVQ    DX, DI
	ADDQ    CX, DI
	MOVBQZX 0(DI), CX
	SHLQ    $16, CX
	ORQ     CX, BX
	PINSRQ  $0, BX, X9

afterMod4:
	PADDQ   X8, X7
	PADDQ   X9, X6
	PADDQ   X2, X7
	PADDQ   X3, X6
	MOVO    X0, X8
	MOVO    X1, X9
	MOVO    X7, X10
	MOVO    X6, X11
	PSRLQ   $32, X8
	PSRLQ   $32, X9
	PMULULQ X8, X10
	PMULULQ X9, X11
	PXOR    X10, X2
	PXOR    X11, X3
	PADDQ   X4, X0
	PADDQ   X5, X1
	MOVO    X7, X8
	MOVO    X6, X9
	MOVO    X0, X10
	MOVO    X1, X11
	PSRLQ   $32, X8
	PSRLQ   $32, X9
	PMULULQ X8, X10
	PMULULQ X9, X11
	PXOR    X10, X4
	PXOR    X11, X5
	MOVQ    $4223284375849987, AX
	MOVQ    AX, X8
	MOVQ    $506661594022413323, AX
	MOVQ    AX, X9
	MOVLHPS X9, X8
	MOVO    X7, X10
	PSHUFB  X8, X10
	MOVO    X6, X11
	PSHUFB  X8, X11
	PADDQ   X10, X0
	PADDQ   X11, X1
	MOVO    X0, X10
	PSHUFB  X8, X10
	MOVO    X1, X11
	PSHUFB  X8, X11
	PADDQ   X10, X7
	PADDQ   X11, X6

finalize:
	MOVQ $4, AX

loop0_begin:
	PSHUFL  $177, X1, X8
	PSHUFL  $177, X0, X9
	PADDQ   X8, X7
	PADDQ   X9, X6
	PADDQ   X2, X7
	PADDQ   X3, X6
	MOVO    X0, X8
	MOVO    X1, X9
	MOVO    X7, X10
	MOVO    X6, X11
	PSRLQ   $32, X8
	PSRLQ   $32, X9
	PMULULQ X8, X10
	PMULULQ X9, X11
	PXOR    X10, X2
	PXOR    X11, X3
	PADDQ   X4, X0
	PADDQ   X5, X1
	MOVO    X7, X8
	MOVO    X6, X9
	MOVO    X0, X10
	MOVO    X1, X11
	PSRLQ   $32, X8
	PSRLQ   $32, X9
	PMULULQ X8, X10
	PMULULQ X9, X11
	PXOR    X10, X4
	PXOR    X11, X5
	MOVQ    $4223284375849987, BX
	MOVQ    BX, X8
	MOVQ    $506661594022413323, BX
	MOVQ    BX, X9
	MOVLHPS X9, X8
	MOVO    X7, X10
	PSHUFB  X8, X10
	MOVO    X6, X11
	PSHUFB  X8, X11
	PADDQ   X10, X0
	PADDQ   X11, X1
	MOVO    X0, X10
	PSHUFB  X8, X10
	MOVO    X1, X11
	PSHUFB  X8, X11
	PADDQ   X10, X7
	PADDQ   X11, X6
	DECQ    AX
	JNE     loop0_begin
	PADDQ   X7, X0
	PADDQ   X4, X2
	PADDQ   X2, X0
	MOVQ    X0, AX
	MOVQ    AX, ret+48(FP)
	RET
