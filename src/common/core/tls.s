	.file	"tls.s"

.globl _tlsstart
	.section	.tdata,"awT",@progbits
	.align 4
	.type	_tlsstart, @object
	.size	_tlsstart, 4
_tlsstart:
	.long	3

.globl _tlsend
	.section	.tbss.end,"awT",@nobits
	.align 4
	.type	_tlsend, @object
	.size	_tlsend, 4
_tlsend:
	.zero	4
