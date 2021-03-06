# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -register-file-size=5 -iterations=5 -verbose -timeline < %s | FileCheck %s

vaddps %xmm0, %xmm0, %xmm0
vmulps %xmm0, %xmm0, %xmm0

# CHECK: Iterations:     5
# CHECK-NEXT: Instructions:   10

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      13

# CHECK:      Register File statistics.
# CHECK-NEXT: Register File #0
# CHECK-NEXT:   Total number of mappings created: 10
# CHECK-NEXT:   Max number of mappings used:      5

# CHECK:      Timeline view:
# CHECK-NEXT:      	          0123456789        
# CHECK-NEXT: Index	0123456789          01234567
# CHECK:      [0,0]	DeeeER    .    .    .    . .	vaddps	%xmm0, %xmm0, %xmm0
# CHECK-NEXT: [0,1]	D===eeER  .    .    .    . .	vmulps	%xmm0, %xmm0, %xmm0
# CHECK:      [1,0]	.D====eeeER    .    .    . .	vaddps	%xmm0, %xmm0, %xmm0
# CHECK-NEXT: [1,1]	.D=======eeER  .    .    . .	vmulps	%xmm0, %xmm0, %xmm0
# CHECK:      [2,0]	. D========eeeER    .    . .	vaddps	%xmm0, %xmm0, %xmm0
# CHECK-NEXT: [2,1]	.    D========eeER  .    . .	vmulps	%xmm0, %xmm0, %xmm0
# CHECK:      [3,0]	.    . D========eeeER    . .	vaddps	%xmm0, %xmm0, %xmm0
# CHECK-NEXT: [3,1]	.    .    D========eeER  . .	vmulps	%xmm0, %xmm0, %xmm0
# CHECK:      [4,0]	.    .    . D========eeeER .	vaddps	%xmm0, %xmm0, %xmm0
# CHECK-NEXT: [4,1]	.    .    .    D========eeER	vmulps	%xmm0, %xmm0, %xmm0
