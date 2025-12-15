	.def	@feat.00;
	.scl	3;
	.type	0;
	.endef
	.globl	@feat.00
@feat.00 = 0
	.file	"test_posixstr.cpp"
	.def	__dtor_keywords;
	.scl	3;
	.type	32;
	.endef
	.text
	.p2align	4                               # -- Begin function __dtor_keywords
__dtor_keywords:                        # @__dtor_keywords
.seh_proc __dtor_keywords
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	movq	keywords(%rip), %rsi
	testq	%rsi, %rsi
	je	.LBB0_7
# %bb.1:
	movq	keywords+8(%rip), %rdi
	movq	%rsi, %rcx
	cmpq	%rdi, %rsi
	jne	.LBB0_2
	jmp	.LBB0_6
	.p2align	4
.LBB0_4:                                #   in Loop: Header=BB0_2 Depth=1
	addq	$-24, %rdi
	cmpq	%rsi, %rdi
	je	.LBB0_5
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
	testb	$1, -24(%rdi)
	je	.LBB0_4
# %bb.3:                                #   in Loop: Header=BB0_2 Depth=1
	movq	-8(%rdi), %rcx
	callq	_ZdlPv
	jmp	.LBB0_4
.LBB0_5:
	movq	keywords(%rip), %rcx
.LBB0_6:
	movq	%rsi, keywords+8(%rip)
	.seh_startepilogue
	addq	$40, %rsp
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	jmp	_ZdlPv                          # TAILCALL
.LBB0_7:
	nop
	.seh_startepilogue
	addq	$40, %rsp
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.def	_Z8mainfuncv;
	.scl	2;
	.type	32;
	.endef
	.globl	_Z8mainfuncv                    # -- Begin function _Z8mainfuncv
	.p2align	4
_Z8mainfuncv:                           # @_Z8mainfuncv
.seh_proc _Z8mainfuncv
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$64, %rsp
	.seh_stackalloc 64
	.seh_endprologue
	leaq	.L.str.62(%rip), %rcx
	movl	$2147483647, %edx               # imm = 0x7FFFFFFF
	callq	printf
	leaq	.L.str.56(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$40, 56(%rsp)
	leaq	48(%rsp), %rcx
	callq	_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
	movl	$0, 44(%rsp)
	leaq	.L.str.63(%rip), %rcx
	leaq	44(%rsp), %rdx
	callq	scanf
	movl	44(%rsp), %esi
	movq	__imp__kbhit(%rip), %rdi
	movq	__imp__getch(%rip), %rbx
	.p2align	4
.LBB1_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_6 Depth 2
                                        #     Child Loop BB1_3 Depth 2
	callq	*%rdi
	testl	%eax, %eax
	je	.LBB1_1
	.p2align	4
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	callq	*%rdi
	testl	%eax, %eax
	je	.LBB1_3
.LBB1_6:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	*%rbx
	callq	*%rdi
	testl	%eax, %eax
	jne	.LBB1_6
	jmp	.LBB1_3
	.p2align	4
.LBB1_5:                                #   in Loop: Header=BB1_3 Depth=2
	callq	*%rbx
.LBB1_3:                                #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	*%rbx
	cmpl	$224, %eax
	je	.LBB1_5
# %bb.4:                                #   in Loop: Header=BB1_3 Depth=2
	testl	%eax, %eax
	je	.LBB1_5
# %bb.7:                                #   in Loop: Header=BB1_1 Depth=1
	andl	$-33, %eax
	cmpl	$65, %eax
	jne	.LBB1_1
# %bb.8:
	leaq	.L.str.62(%rip), %rcx
	movl	%esi, %edx
	callq	printf
	leaq	.L.str.63(%rip), %rcx
	movl	$1, %edx
	callq	printf
	leaq	.L.str.65(%rip), %rcx
	movl	$65, %edx
	callq	printf
	movl	$32, %ecx
	callq	_Znwy
	movq	%rax, %rsi
	movups	.L.str.54(%rip), %xmm0
	movups	%xmm0, (%rax)
	movups	.L.str.54+9(%rip), %xmm0
	movups	%xmm0, 9(%rax)
	movb	$0, 25(%rax)
	leaq	.L.str.68(%rip), %rcx
	movq	%rax, %rdx
	callq	printf
	movq	%rsi, %rcx
	callq	_ZdlPv
	xorl	%eax, %eax
	.seh_startepilogue
	addq	$64, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.def	_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE,"xr",discard,_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
	.globl	_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE # -- Begin function _Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
	.p2align	4
_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE: # @_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
.Lfunc_begin0:
.seh_proc _Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
	.seh_handler __gxx_personality_seh0, @unwind, @except
# %bb.0:
	pushq	%r15
	.seh_pushreg %r15
	pushq	%r14
	.seh_pushreg %r14
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$80, %rsp
	.seh_stackalloc 80
	.seh_endprologue
	movq	%rcx, %rsi
.Ltmp0:
	movl	$40, %ecx
	callq	_Znwy
.Ltmp1:
# %bb.1:
	movq	%rax, 72(%rsp)
	movq	$41, 56(%rsp)
	movq	$33, 64(%rsp)
	movups	.L.str.59+16(%rip), %xmm0
	movups	%xmm0, 16(%rax)
	movups	.L.str.59(%rip), %xmm0
	movups	%xmm0, (%rax)
	movw	$34, 32(%rax)
	movq	8(%rsi), %rdi
	cmpq	$-9, %rdi
	jae	.LBB2_2
# %bb.4:
	movq	(%rsi), %rbx
	leaq	33(%rsp), %rsi
	cmpq	$23, %rdi
	jae	.LBB2_5
# %bb.7:
	leal	(%rdi,%rdi), %eax
	movb	%al, 32(%rsp)
	movq	%rsi, %r14
	testq	%rdi, %rdi
	jne	.LBB2_8
	jmp	.LBB2_9
.LBB2_5:
	movq	%rdi, %rax
	orq	$7, %rax
	leaq	1(%rax), %rcx
	cmpq	$23, %rax
	movl	$26, %r15d
	cmovneq	%rcx, %r15
.Ltmp2:
	movq	%r15, %rcx
	callq	_Znwy
.Ltmp3:
# %bb.6:
	movq	%rax, %r14
	movq	%rax, 48(%rsp)
	orq	$1, %r15
	movq	%r15, 32(%rsp)
	movq	%rdi, 40(%rsp)
.LBB2_8:
	movq	%r14, %rcx
	movq	%rbx, %rdx
	movq	%rdi, %r8
	callq	memmove
.LBB2_9:
	movb	$0, (%r14,%rdi)
	movzbl	32(%rsp), %eax
	movl	%eax, %r8d
	shrl	%r8d
	testb	$1, %al
	cmovneq	48(%rsp), %rsi
	cmovneq	40(%rsp), %r8
.Ltmp4:
	leaq	56(%rsp), %rcx
	movq	%rsi, %rdx
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcy
.Ltmp5:
# %bb.10:
	testb	$1, 32(%rsp)
	je	.LBB2_12
# %bb.11:
	movq	48(%rsp), %rcx
	callq	_ZdlPv
.LBB2_12:
.Ltmp6:
	leaq	.L.str.60(%rip), %rdx
	leaq	56(%rsp), %rcx
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKc
.Ltmp7:
# %bb.13:
	testb	$1, 56(%rsp)
	je	.LBB2_14
# %bb.15:
	movq	72(%rsp), %rcx
	jmp	.LBB2_16
.LBB2_14:
	leaq	57(%rsp), %rcx
.LBB2_16:
.Ltmp8:
	callq	system
.Ltmp9:
# %bb.17:
	testb	$1, 56(%rsp)
	je	.LBB2_19
# %bb.18:
	movq	72(%rsp), %rcx
	movl	%eax, %esi
	callq	_ZdlPv
	movl	%esi, %eax
.LBB2_19:
	.seh_startepilogue
	addq	$80, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	popq	%r15
	.seh_endepilogue
	retq
.LBB2_2:
.Ltmp10:
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev
.Ltmp11:
# %bb.3:
.LBB2_20:
.Ltmp12:
	movq	%rax, %rcx
	callq	__clang_call_terminate
	int3
.Lfunc_end0:
	.seh_handlerdata
	.section	.text$_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE,"xr",discard,_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
	.seh_endproc
	.section	.xdata$_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE,"dr"
	.linkonce	discard
	.p2align	2, 0x0
GCC_except_table2:
.Lexception0:
	.byte	255                             # @LPStart Encoding = omit
	.byte	0                               # @TType Encoding = absptr
	.uleb128 .Lttbase0-.Lttbaseref0
.Lttbaseref0:
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Ltmp0-.Lfunc_begin0           # >> Call Site 1 <<
	.uleb128 .Ltmp3-.Ltmp0                  #   Call between .Ltmp0 and .Ltmp3
	.uleb128 .Ltmp12-.Lfunc_begin0          #     jumps to .Ltmp12
	.byte	1                               #   On action: 1
	.uleb128 .Ltmp3-.Lfunc_begin0           # >> Call Site 2 <<
	.uleb128 .Ltmp4-.Ltmp3                  #   Call between .Ltmp3 and .Ltmp4
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp4-.Lfunc_begin0           # >> Call Site 3 <<
	.uleb128 .Ltmp11-.Ltmp4                 #   Call between .Ltmp4 and .Ltmp11
	.uleb128 .Ltmp12-.Lfunc_begin0          #     jumps to .Ltmp12
	.byte	1                               #   On action: 1
.Lcst_end0:
	.byte	1                               # >> Action Record 1 <<
                                        #   Catch TypeInfo 1
	.byte	0                               #   No further actions
	.p2align	2, 0x0
                                        # >> Catch TypeInfos <<
	.quad	0                               # TypeInfo 1
.Lttbase0:
	.p2align	2, 0x0
	.section	.text$_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE,"xr",discard,_Z17call_sound_playerNSt3__117basic_string_viewIcNS_11char_traitsIcEEEE
                                        # -- End function
	.def	main;
	.scl	2;
	.type	32;
	.endef
	.text
	.globl	main                            # -- Begin function main
	.p2align	4
main:                                   # @main
.seh_proc main
# %bb.0:
	pushq	%rbp
	.seh_pushreg %rbp
	subq	$32, %rsp
	.seh_stackalloc 32
	leaq	32(%rsp), %rbp
	.seh_setframe %rbp, 32
	.seh_endprologue
	callq	__main
	callq	_Z8mainfuncv
	xorl	%eax, %eax
	.seh_startepilogue
	addq	$32, %rsp
	popq	%rbp
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.def	__clang_call_terminate;
	.scl	2;
	.type	32;
	.endef
	.section	.text$__clang_call_terminate,"xr",discard,__clang_call_terminate
	.globl	__clang_call_terminate          # -- Begin function __clang_call_terminate
	.p2align	4
__clang_call_terminate:                 # @__clang_call_terminate
.seh_proc __clang_call_terminate
# %bb.0:
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	callq	__cxa_begin_catch
	callq	_ZSt9terminatev
	int3
	.seh_endproc
                                        # -- End function
	.def	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev,"xr",discard,_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev
	.globl	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev # -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev
	.p2align	4
_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev: # @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev
.seh_proc _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev
# %bb.0:
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	leaq	.L.str.61(%rip), %rcx
	callq	_ZNSt3__120__throw_length_errorB8ne210101EPKc
	int3
	.seh_endproc
                                        # -- End function
	.def	_ZNSt3__120__throw_length_errorB8ne210101EPKc;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__120__throw_length_errorB8ne210101EPKc,"xr",discard,_ZNSt3__120__throw_length_errorB8ne210101EPKc
	.globl	_ZNSt3__120__throw_length_errorB8ne210101EPKc # -- Begin function _ZNSt3__120__throw_length_errorB8ne210101EPKc
	.p2align	4
_ZNSt3__120__throw_length_errorB8ne210101EPKc: # @_ZNSt3__120__throw_length_errorB8ne210101EPKc
.Lfunc_begin1:
.seh_proc _ZNSt3__120__throw_length_errorB8ne210101EPKc
	.seh_handler __gxx_personality_seh0, @unwind, @except
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	movq	%rcx, %rdi
	movl	$16, %ecx
	callq	__cxa_allocate_exception
	movq	%rax, %rsi
.Ltmp13:
	movq	%rax, %rcx
	movq	%rdi, %rdx
	callq	_ZNSt12length_errorC2B8ne210101EPKc
.Ltmp14:
# %bb.1:
	leaq	_ZTISt12length_error(%rip), %rdx
	leaq	_ZNSt12length_errorD1Ev(%rip), %r8
	movq	%rsi, %rcx
	callq	__cxa_throw
.LBB6_2:
.Ltmp15:
	movq	%rax, %rdi
	movq	%rsi, %rcx
	callq	__cxa_free_exception
	movq	%rdi, %rcx
	callq	_Unwind_Resume
	int3
.Lfunc_end1:
	.seh_handlerdata
	.section	.text$_ZNSt3__120__throw_length_errorB8ne210101EPKc,"xr",discard,_ZNSt3__120__throw_length_errorB8ne210101EPKc
	.seh_endproc
	.section	.xdata$_ZNSt3__120__throw_length_errorB8ne210101EPKc,"dr"
	.linkonce	discard
	.p2align	2, 0x0
GCC_except_table6:
.Lexception1:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end1-.Lcst_begin1
.Lcst_begin1:
	.uleb128 .Lfunc_begin1-.Lfunc_begin1    # >> Call Site 1 <<
	.uleb128 .Ltmp13-.Lfunc_begin1          #   Call between .Lfunc_begin1 and .Ltmp13
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp13-.Lfunc_begin1          # >> Call Site 2 <<
	.uleb128 .Ltmp14-.Ltmp13                #   Call between .Ltmp13 and .Ltmp14
	.uleb128 .Ltmp15-.Lfunc_begin1          #     jumps to .Ltmp15
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp14-.Lfunc_begin1          # >> Call Site 3 <<
	.uleb128 .Lfunc_end1-.Ltmp14            #   Call between .Ltmp14 and .Lfunc_end1
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end1:
	.p2align	2, 0x0
	.section	.text$_ZNSt3__120__throw_length_errorB8ne210101EPKc,"xr",discard,_ZNSt3__120__throw_length_errorB8ne210101EPKc
                                        # -- End function
	.def	_ZNSt12length_errorC2B8ne210101EPKc;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt12length_errorC2B8ne210101EPKc,"xr",discard,_ZNSt12length_errorC2B8ne210101EPKc
	.globl	_ZNSt12length_errorC2B8ne210101EPKc # -- Begin function _ZNSt12length_errorC2B8ne210101EPKc
	.p2align	4
_ZNSt12length_errorC2B8ne210101EPKc:    # @_ZNSt12length_errorC2B8ne210101EPKc
.seh_proc _ZNSt12length_errorC2B8ne210101EPKc
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	subq	$32, %rsp
	.seh_stackalloc 32
	.seh_endprologue
	movq	%rcx, %rsi
	callq	_ZNSt11logic_errorC2EPKc
	movq	.refptr._ZTVSt12length_error(%rip), %rax
	addq	$16, %rax
	movq	%rax, (%rsi)
	.seh_startepilogue
	addq	$32, %rsp
	popq	%rsi
	.seh_endepilogue
	retq
	.seh_endproc
                                        # -- End function
	.def	_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y,"xr",discard,_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
	.globl	_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y # -- Begin function _ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
	.p2align	4
_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y: # @_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
.Lfunc_begin2:
.seh_proc _ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
	.seh_handler __gxx_personality_seh0, @unwind, @except
# %bb.0:
	pushq	%r15
	.seh_pushreg %r15
	pushq	%r14
	.seh_pushreg %r14
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$96, %rsp
	.seh_stackalloc 96
	.seh_endprologue
	movq	%rcx, 48(%rsp)
	movb	$0, 56(%rsp)
	testq	%r9, %r9
	je	.LBB8_14
# %bb.1:
	movq	%r9, %r15
	movabsq	$768614336404564651, %rax       # imm = 0xAAAAAAAAAAAAAAB
	cmpq	%rax, %r9
	jae	.LBB8_2
# %bb.4:
	movq	%r8, %rdi
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	leaq	(,%r15,8), %rax
	leaq	(%rax,%rax,2), %rcx
.Ltmp16:
	callq	_Znwy
.Ltmp17:
# %bb.5:
	movq	%rax, %r14
	leaq	16(%rsi), %rax
	movq	%r14, (%rsi)
	movq	%r14, 8(%rsi)
	leaq	(%r15,%r15,2), %rcx
	leaq	(%r14,%rcx,8), %rcx
	movq	%rcx, 16(%rsi)
	movq	%r14, 32(%rsp)
	movq	%r14, 40(%rsp)
	movq	%rax, 64(%rsp)
	leaq	40(%rsp), %rax
	movq	%rax, 72(%rsp)
	leaq	32(%rsp), %rax
	movq	%rax, 80(%rsp)
	movb	$0, 88(%rsp)
	cmpq	%rdi, %rbx
	je	.LBB8_6
# %bb.7:
	movq	%r14, %rcx
	jmp	.LBB8_8
	.p2align	4
.LBB8_9:                                #   in Loop: Header=BB8_8 Depth=1
	movq	16(%rbx), %rax
	movq	%rax, 16(%rcx)
	movups	(%rbx), %xmm0
	movups	%xmm0, (%rcx)
.LBB8_12:                               #   in Loop: Header=BB8_8 Depth=1
	addq	$24, %rbx
	addq	$24, %rcx
	movq	%rcx, 32(%rsp)
	cmpq	%rdi, %rbx
	je	.LBB8_13
.LBB8_8:                                # =>This Inner Loop Header: Depth=1
	testb	$1, (%rbx)
	je	.LBB8_9
# %bb.10:                               #   in Loop: Header=BB8_8 Depth=1
	movq	8(%rbx), %r8
	movq	16(%rbx), %rdx
.Ltmp18:
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy
.Ltmp19:
# %bb.11:                               #   in Loop: Header=BB8_8 Depth=1
	movq	32(%rsp), %rcx
	jmp	.LBB8_12
.LBB8_6:
	movq	%r14, %rcx
.LBB8_13:
	movq	%rcx, 8(%rsi)
.LBB8_14:
	.seh_startepilogue
	addq	$96, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	popq	%r15
	.seh_endepilogue
	retq
.LBB8_2:
.Ltmp21:
	callq	_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev
.Ltmp22:
# %bb.3:
.LBB8_15:
.Ltmp23:
	movq	%rax, %rdi
	leaq	48(%rsp), %rcx
	callq	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev
	movq	%rdi, %rcx
	callq	_Unwind_Resume
.LBB8_17:
.Ltmp20:
	movq	%rax, %rdi
	leaq	64(%rsp), %rcx
	callq	_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev
	movq	%r14, 8(%rsi)
	leaq	48(%rsp), %rcx
	callq	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev
	movq	%rdi, %rcx
	callq	_Unwind_Resume
	int3
.Lfunc_end2:
	.seh_handlerdata
	.section	.text$_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y,"xr",discard,_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
	.seh_endproc
	.section	.xdata$_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y,"dr"
	.linkonce	discard
	.p2align	2, 0x0
GCC_except_table8:
.Lexception2:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end2-.Lcst_begin2
.Lcst_begin2:
	.uleb128 .Ltmp16-.Lfunc_begin2          # >> Call Site 1 <<
	.uleb128 .Ltmp17-.Ltmp16                #   Call between .Ltmp16 and .Ltmp17
	.uleb128 .Ltmp23-.Lfunc_begin2          #     jumps to .Ltmp23
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp18-.Lfunc_begin2          # >> Call Site 2 <<
	.uleb128 .Ltmp19-.Ltmp18                #   Call between .Ltmp18 and .Ltmp19
	.uleb128 .Ltmp20-.Lfunc_begin2          #     jumps to .Ltmp20
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp21-.Lfunc_begin2          # >> Call Site 3 <<
	.uleb128 .Ltmp22-.Ltmp21                #   Call between .Ltmp21 and .Ltmp22
	.uleb128 .Ltmp23-.Lfunc_begin2          #     jumps to .Ltmp23
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp22-.Lfunc_begin2          # >> Call Site 4 <<
	.uleb128 .Lfunc_end2-.Ltmp22            #   Call between .Ltmp22 and .Lfunc_end2
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end2:
	.p2align	2, 0x0
	.section	.text$_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y,"xr",discard,_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
                                        # -- End function
	.def	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev,"xr",discard,_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev
	.globl	_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev # -- Begin function _ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev
	.p2align	4
_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev: # @_ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev
.seh_proc _ZNSt3__128__exception_guard_exceptionsINS_6vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS5_IS7_EEE16__destroy_vectorEED2B8ne210101Ev
# %bb.0:
	pushq	%r14
	.seh_pushreg %r14
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	cmpb	$0, 8(%rcx)
	jne	.LBB9_8
# %bb.1:
	movq	%rcx, %rsi
	movq	(%rcx), %rdi
	movq	(%rdi), %rbx
	testq	%rbx, %rbx
	je	.LBB9_8
# %bb.2:
	movq	8(%rdi), %r14
	movq	%rbx, %rcx
	cmpq	%r14, %rbx
	jne	.LBB9_3
	jmp	.LBB9_7
	.p2align	4
.LBB9_5:                                #   in Loop: Header=BB9_3 Depth=1
	addq	$-24, %r14
	cmpq	%rbx, %r14
	je	.LBB9_6
.LBB9_3:                                # =>This Inner Loop Header: Depth=1
	testb	$1, -24(%r14)
	je	.LBB9_5
# %bb.4:                                #   in Loop: Header=BB9_3 Depth=1
	movq	-8(%r14), %rcx
	callq	_ZdlPv
	jmp	.LBB9_5
.LBB9_8:
	.seh_startepilogue
	addq	$40, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	.seh_endepilogue
	retq
.LBB9_6:
	movq	(%rsi), %rax
	movq	(%rax), %rcx
.LBB9_7:
	movq	%rbx, 8(%rdi)
	.seh_startepilogue
	addq	$40, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	.seh_endepilogue
	jmp	_ZdlPv                          # TAILCALL
	.seh_endproc
                                        # -- End function
	.def	_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev,"xr",discard,_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev
	.globl	_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev # -- Begin function _ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev
	.p2align	4
_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev: # @_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev
.seh_proc _ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE20__throw_length_errorB8ne210101Ev
# %bb.0:
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	leaq	.L.str.69(%rip), %rcx
	callq	_ZNSt3__120__throw_length_errorB8ne210101EPKc
	int3
	.seh_endproc
                                        # -- End function
	.def	_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev,"xr",discard,_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev
	.globl	_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev # -- Begin function _ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev
	.p2align	4
_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev: # @_ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev
.seh_proc _ZNSt3__128__exception_guard_exceptionsINS_29_AllocatorDestroyRangeReverseINS_9allocatorINS_12basic_stringIcNS_11char_traitsIcEENS2_IcEEEEEEPS7_EEED2B8ne210101Ev
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	cmpb	$0, 24(%rcx)
	je	.LBB11_1
.LBB11_6:
	.seh_startepilogue
	addq	$40, %rsp
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	retq
.LBB11_1:
	movq	8(%rcx), %rax
	movq	16(%rcx), %rcx
	movq	(%rcx), %rsi
	movq	(%rax), %rdi
	jmp	.LBB11_2
	.p2align	4
.LBB11_5:                               #   in Loop: Header=BB11_2 Depth=1
	addq	$-24, %rsi
.LBB11_2:                               # =>This Inner Loop Header: Depth=1
	cmpq	%rdi, %rsi
	je	.LBB11_6
# %bb.3:                                #   in Loop: Header=BB11_2 Depth=1
	testb	$1, -24(%rsi)
	je	.LBB11_5
# %bb.4:                                #   in Loop: Header=BB11_2 Depth=1
	movq	-8(%rsi), %rcx
	callq	_ZdlPv
	jmp	.LBB11_5
	.seh_endproc
                                        # -- End function
	.def	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy;
	.scl	2;
	.type	32;
	.endef
	.section	.text$_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy,"xr",discard,_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy
	.globl	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy # -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy
	.p2align	4
_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy: # @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy
.seh_proc _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE25__init_copy_ctor_externalEPKcy
# %bb.0:
	pushq	%r14
	.seh_pushreg %r14
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	pushq	%rbx
	.seh_pushreg %rbx
	subq	$40, %rsp
	.seh_stackalloc 40
	.seh_endprologue
	cmpq	$22, %r8
	ja	.LBB12_2
# %bb.1:
	leal	(%r8,%r8), %eax
	movb	%al, (%rcx)
	incq	%rcx
	jmp	.LBB12_4
.LBB12_2:
	cmpq	$-9, %r8
	jae	.LBB12_5
# %bb.3:
	movq	%rcx, %rbx
	movq	%rdx, %rdi
	movq	%r8, %rax
	orq	$7, %rax
	leaq	1(%rax), %rcx
	cmpq	$23, %rax
	movl	$26, %esi
	cmovneq	%rcx, %rsi
	movq	%rsi, %rcx
	movq	%r8, %r14
	callq	_Znwy
	movq	%r14, %r8
	movq	%rax, 16(%rbx)
	incq	%rsi
	movq	%rsi, (%rbx)
	movq	%r14, 8(%rbx)
	movq	%rax, %rcx
	movq	%rdi, %rdx
.LBB12_4:
	incq	%r8
	.seh_startepilogue
	addq	$40, %rsp
	popq	%rbx
	popq	%rdi
	popq	%rsi
	popq	%r14
	.seh_endepilogue
	jmp	memmove                         # TAILCALL
.LBB12_5:
	callq	_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne210101Ev
	int3
	.seh_endproc
                                        # -- End function
	.def	_GLOBAL__sub_I_test_posixstr.cpp;
	.scl	3;
	.type	32;
	.endef
	.text
	.p2align	4                               # -- Begin function _GLOBAL__sub_I_test_posixstr.cpp
_GLOBAL__sub_I_test_posixstr.cpp:       # @_GLOBAL__sub_I_test_posixstr.cpp
.Lfunc_begin3:
.seh_proc _GLOBAL__sub_I_test_posixstr.cpp
	.seh_handler __gxx_personality_seh0, @unwind, @except
# %bb.0:
	pushq	%rsi
	.seh_pushreg %rsi
	pushq	%rdi
	.seh_pushreg %rdi
	subq	$1336, %rsp                     # imm = 0x538
	.seh_stackalloc 1336
	.seh_endprologue
	movb	$4, 40(%rsp)
	movw	$26217, 41(%rsp)                # imm = 0x6669
	movb	$0, 43(%rsp)
	movb	$8, 64(%rsp)
	movl	$1702063205, 65(%rsp)           # imm = 0x65736C65
	movb	$0, 69(%rsp)
	movb	$10, 88(%rsp)
	movl	$1818847351, 89(%rsp)           # imm = 0x6C696877
	movw	$101, 93(%rsp)
	movb	$6, 112(%rsp)
	movl	$7499622, 113(%rsp)             # imm = 0x726F66
	movb	$12, 136(%rsp)
	movl	$1970562418, 137(%rsp)          # imm = 0x75746572
	movw	$28274, 141(%rsp)               # imm = 0x6E72
	movb	$0, 143(%rsp)
	movb	$10, 160(%rsp)
	movl	$1634038370, 161(%rsp)          # imm = 0x61657262
	movw	$107, 165(%rsp)
	movb	$16, 184(%rsp)
	movabsq	$7310870969309884259, %rax      # imm = 0x65756E69746E6F63
	movq	%rax, 185(%rsp)
	movb	$0, 193(%rsp)
	movb	$12, 208(%rsp)
	movw	$26723, 213(%rsp)               # imm = 0x6863
	movl	$1953068915, 209(%rsp)          # imm = 0x74697773
	movb	$0, 215(%rsp)
	movb	$8, 232(%rsp)
	movl	$1702060387, 233(%rsp)          # imm = 0x65736163
	movb	$0, 237(%rsp)
	movb	$14, 256(%rsp)
	movl	$1634100580, 257(%rsp)          # imm = 0x61666564
	movl	$1953264993, 260(%rsp)          # imm = 0x746C7561
	movb	$0, 264(%rsp)
	movb	$4, 280(%rsp)
	movw	$28516, 281(%rsp)               # imm = 0x6F64
	movb	$0, 283(%rsp)
	movb	$6, 304(%rsp)
	movl	$7959156, 305(%rsp)             # imm = 0x797274
	movb	$10, 328(%rsp)
	movl	$1668571491, 329(%rsp)          # imm = 0x63746163
	movb	$104, 333(%rsp)
	movb	$0, 334(%rsp)
	movb	$10, 352(%rsp)
	movb	$119, 357(%rsp)
	movl	$1869768820, 353(%rsp)          # imm = 0x6F726874
	movb	$0, 358(%rsp)
	movb	$10, 376(%rsp)
	movb	$115, 381(%rsp)
	movl	$1935764579, 377(%rsp)          # imm = 0x73616C63
	movb	$0, 382(%rsp)
	movb	$12, 400(%rsp)
	movw	$25449, 405(%rsp)               # imm = 0x6369
	movl	$1818391920, 401(%rsp)          # imm = 0x6C627570
	movb	$0, 407(%rsp)
	movb	$14, 424(%rsp)
	movl	$1702125942, 428(%rsp)          # imm = 0x65746176
	movl	$1986622064, 425(%rsp)          # imm = 0x76697270
	movb	$0, 432(%rsp)
	movb	$18, 448(%rsp)
	movabsq	$7310577382525465200, %rax      # imm = 0x65746365746F7270
	movq	%rax, 449(%rsp)
	movb	$100, 457(%rsp)
	movb	$0, 458(%rsp)
	movb	$12, 472(%rsp)
	movw	$25449, 477(%rsp)               # imm = 0x6369
	movl	$1952543859, 473(%rsp)          # imm = 0x74617473
	movb	$0, 479(%rsp)
	movb	$8, 496(%rsp)
	movl	$1684631414, 497(%rsp)          # imm = 0x64696F76
	movb	$0, 501(%rsp)
	movb	$6, 520(%rsp)
	movb	$116, 523(%rsp)
	movw	$28265, 521(%rsp)               # imm = 0x6E69
	movb	$0, 524(%rsp)
	movb	$10, 544(%rsp)
	movb	$116, 549(%rsp)
	movl	$1634692198, 545(%rsp)          # imm = 0x616F6C66
	movb	$0, 550(%rsp)
	movb	$12, 568(%rsp)
	movw	$25964, 573(%rsp)               # imm = 0x656C
	movl	$1651863396, 569(%rsp)          # imm = 0x62756F64
	movb	$0, 575(%rsp)
	movb	$8, 592(%rsp)
	movl	$1918986339, 593(%rsp)          # imm = 0x72616863
	movb	$0, 597(%rsp)
	movb	$8, 616(%rsp)
	movl	$1819242338, 617(%rsp)          # imm = 0x6C6F6F62
	movb	$0, 621(%rsp)
	movb	$12, 640(%rsp)
	movw	$26478, 645(%rsp)               # imm = 0x676E
	movl	$1769108595, 641(%rsp)          # imm = 0x69727473
	movb	$0, 647(%rsp)
	movb	$10, 664(%rsp)
	movb	$116, 669(%rsp)
	movl	$1936617315, 665(%rsp)          # imm = 0x736E6F63
	movb	$0, 670(%rsp)
	movb	$8, 688(%rsp)
	movl	$1869903201, 689(%rsp)          # imm = 0x6F747561
	movb	$0, 693(%rsp)
	movb	$10, 712(%rsp)
	movb	$103, 717(%rsp)
	movl	$1852404597, 713(%rsp)          # imm = 0x6E697375
	movb	$0, 718(%rsp)
	movb	$18, 736(%rsp)
	movabsq	$7161128523421016430, %rax      # imm = 0x63617073656D616E
	movq	%rax, 737(%rsp)
	movb	$101, 745(%rsp)
	movb	$0, 746(%rsp)
	movb	$14, 760(%rsp)
	movl	$1701082476, 764(%rsp)          # imm = 0x6564756C
	movl	$1818455657, 761(%rsp)          # imm = 0x6C636E69
	movb	$0, 768(%rsp)
	movb	$12, 784(%rsp)
	movw	$25966, 789(%rsp)               # imm = 0x656E
	movl	$1768318308, 785(%rsp)          # imm = 0x69666564
	movb	$0, 791(%rsp)
	movb	$12, 808(%rsp)
	movw	$29795, 813(%rsp)               # imm = 0x7463
	movl	$1970435187, 809(%rsp)          # imm = 0x75727473
	movb	$0, 815(%rsp)
	movb	$10, 832(%rsp)
	movb	$110, 837(%rsp)
	movl	$1869180533, 833(%rsp)          # imm = 0x6F696E75
	movb	$0, 838(%rsp)
	movb	$8, 856(%rsp)
	movl	$1836412517, 857(%rsp)          # imm = 0x6D756E65
	movb	$0, 861(%rsp)
	movb	$16, 880(%rsp)
	movabsq	$7310575213499737460, %rax      # imm = 0x6574616C706D6574
	movq	%rax, 881(%rsp)
	movb	$0, 889(%rsp)
	movb	$16, 904(%rsp)
	movabsq	$7308604897068349812, %rax      # imm = 0x656D616E65707974
	movq	%rax, 905(%rsp)
	movb	$0, 913(%rsp)
	movb	$8, 928(%rsp)
	movl	$1936287860, 929(%rsp)          # imm = 0x73696874
	movb	$0, 933(%rsp)
	movb	$24, 952(%rsp)
	movabsq	$7957704859257305459, %rax      # imm = 0x6E6F7268636E7973
	movq	%rax, 953(%rsp)
	movl	$1684372073, 961(%rsp)          # imm = 0x64657A69
	movb	$0, 965(%rsp)
	movb	$16, 976(%rsp)
	movabsq	$7308332243887091574, %rax      # imm = 0x656C6974616C6F76
	movq	%rax, 977(%rsp)
	movb	$0, 985(%rsp)
	movb	$12, 1000(%rsp)
	movw	$28274, 1005(%rsp)              # imm = 0x6E72
	movl	$1702131813, 1001(%rsp)         # imm = 0x65747865
	movb	$0, 1007(%rsp)
	movb	$12, 1024(%rsp)
	movw	$26223, 1029(%rsp)              # imm = 0x666F
	movl	$1702521203, 1025(%rsp)         # imm = 0x657A6973
	movb	$0, 1031(%rsp)
	movb	$14, 1048(%rsp)
	movl	$1718578791, 1052(%rsp)         # imm = 0x666F6E67
	movl	$1734962273, 1049(%rsp)         # imm = 0x67696C61
	movb	$0, 1056(%rsp)
	movb	$8, 1072(%rsp)
	movl	$1735290732, 1073(%rsp)         # imm = 0x676E6F6C
	movb	$0, 1077(%rsp)
	movb	$10, 1096(%rsp)
	movb	$116, 1101(%rsp)
	movl	$1919903859, 1097(%rsp)         # imm = 0x726F6873
	movb	$0, 1102(%rsp)
	movb	$12, 1120(%rsp)
	movw	$25701, 1125(%rsp)              # imm = 0x6465
	movl	$1852270963, 1121(%rsp)         # imm = 0x6E676973
	movb	$0, 1127(%rsp)
	movb	$16, 1144(%rsp)
	movabsq	$7234309766870429301, %rax      # imm = 0x64656E6769736E75
	movq	%rax, 1145(%rsp)
	movb	$0, 1153(%rsp)
	movb	$16, 1168(%rsp)
	movabsq	$8388345085396285541, %rax      # imm = 0x746963696C707865
	movq	%rax, 1169(%rsp)
	movb	$0, 1177(%rsp)
	movb	$12, 1192(%rsp)
	movw	$25710, 1197(%rsp)              # imm = 0x646E
	movl	$1701409382, 1193(%rsp)         # imm = 0x65697266
	movb	$0, 1199(%rsp)
	movb	$18, 1216(%rsp)
	movabsq	$7161117524010233417, %rax      # imm = 0x6361667265746E49
	movq	%rax, 1217(%rsp)
	movb	$101, 1225(%rsp)
	movb	$0, 1226(%rsp)
	movb	$16, 1240(%rsp)
	movabsq	$8386654075301880417, %rax      # imm = 0x7463617274736261
	movq	%rax, 1241(%rsp)
	movb	$0, 1249(%rsp)
	movb	$10, 1264(%rsp)
	movb	$108, 1269(%rsp)
	movl	$1634625894, 1265(%rsp)         # imm = 0x616E6966
	movb	$0, 1270(%rsp)
	movb	$12, 1288(%rsp)
	movw	$25974, 1293(%rsp)              # imm = 0x6576
	movl	$1769234798, 1289(%rsp)         # imm = 0x6974616E
	movb	$0, 1295(%rsp)
	movb	$16, 1312(%rsp)
	movabsq	$8099288950192108659, %rax      # imm = 0x7066746369727473
	movq	%rax, 1313(%rsp)
	movb	$0, 1321(%rsp)
	xorps	%xmm0, %xmm0
	movups	%xmm0, keywords(%rip)
	movq	$0, keywords+16(%rip)
	leaq	keywords(%rip), %rcx
	leaq	1336(%rsp), %r8
.Ltmp24:
	leaq	40(%rsp), %rdx
	movl	$54, %r9d
	callq	_ZNSt3__16vectorINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEENS4_IS6_EEE16__init_with_sizeB8ne210101IPKS6_SB_EEvT_T0_y
.Ltmp25:
# %bb.1:
	movl	$1296, %esi                     # imm = 0x510
	jmp	.LBB13_2
	.p2align	4
.LBB13_4:                               #   in Loop: Header=BB13_2 Depth=1
	addq	$-24, %rsi
	je	.LBB13_5
.LBB13_2:                               # =>This Inner Loop Header: Depth=1
	testb	$1, 16(%rsp,%rsi)
	je	.LBB13_4
# %bb.3:                                #   in Loop: Header=BB13_2 Depth=1
	movq	32(%rsp,%rsi), %rcx
	callq	_ZdlPv
	jmp	.LBB13_4
.LBB13_5:
	leaq	__dtor_keywords(%rip), %rcx
	callq	atexit
	nop
	.seh_startepilogue
	addq	$1336, %rsp                     # imm = 0x538
	popq	%rdi
	popq	%rsi
	.seh_endepilogue
	retq
.LBB13_6:
.Ltmp26:
	movq	%rax, %rsi
	movl	$1296, %edi                     # imm = 0x510
	jmp	.LBB13_7
	.p2align	4
.LBB13_9:                               #   in Loop: Header=BB13_7 Depth=1
	addq	$-24, %rdi
	je	.LBB13_10
.LBB13_7:                               # =>This Inner Loop Header: Depth=1
	testb	$1, 16(%rsp,%rdi)
	je	.LBB13_9
# %bb.8:                                #   in Loop: Header=BB13_7 Depth=1
	movq	32(%rsp,%rdi), %rcx
	callq	_ZdlPv
	jmp	.LBB13_9
.LBB13_10:
	movq	%rsi, %rcx
	callq	_Unwind_Resume
	int3
.Lfunc_end3:
	.seh_handlerdata
	.text
	.seh_endproc
	.section	.xdata,"dr"
	.p2align	2, 0x0
GCC_except_table13:
.Lexception3:
	.byte	255                             # @LPStart Encoding = omit
	.byte	255                             # @TType Encoding = omit
	.byte	1                               # Call site Encoding = uleb128
	.uleb128 .Lcst_end3-.Lcst_begin3
.Lcst_begin3:
	.uleb128 .Ltmp24-.Lfunc_begin3          # >> Call Site 1 <<
	.uleb128 .Ltmp25-.Ltmp24                #   Call between .Ltmp24 and .Ltmp25
	.uleb128 .Ltmp26-.Lfunc_begin3          #     jumps to .Ltmp26
	.byte	0                               #   On action: cleanup
	.uleb128 .Ltmp25-.Lfunc_begin3          # >> Call Site 2 <<
	.uleb128 .Lfunc_end3-.Ltmp25            #   Call between .Ltmp25 and .Lfunc_end3
	.byte	0                               #     has no landing pad
	.byte	0                               #   On action: cleanup
.Lcst_end3:
	.p2align	2, 0x0
	.text
                                        # -- End function
	.bss
	.globl	keywords                        # @keywords
	.p2align	3, 0x0
keywords:
	.zero	24

	.section	.rdata,"dr"
.L.str.2:                               # @.str.2
	.asciz	"while"

.L.str.3:                               # @.str.3
	.asciz	"for"

.L.str.4:                               # @.str.4
	.asciz	"return"

.L.str.5:                               # @.str.5
	.asciz	"break"

.L.str.7:                               # @.str.7
	.asciz	"switch"

.L.str.9:                               # @.str.9
	.asciz	"default"

.L.str.11:                              # @.str.11
	.asciz	"try"

.L.str.12:                              # @.str.12
	.asciz	"catch"

.L.str.13:                              # @.str.13
	.asciz	"throw"

.L.str.14:                              # @.str.14
	.asciz	"class"

.L.str.15:                              # @.str.15
	.asciz	"public"

.L.str.16:                              # @.str.16
	.asciz	"private"

.L.str.17:                              # @.str.17
	.asciz	"protected"

.L.str.18:                              # @.str.18
	.asciz	"static"

.L.str.20:                              # @.str.20
	.asciz	"int"

.L.str.21:                              # @.str.21
	.asciz	"float"

.L.str.22:                              # @.str.22
	.asciz	"double"

.L.str.25:                              # @.str.25
	.asciz	"string"

.L.str.26:                              # @.str.26
	.asciz	"const"

.L.str.28:                              # @.str.28
	.asciz	"using"

.L.str.29:                              # @.str.29
	.asciz	"namespace"

.L.str.30:                              # @.str.30
	.asciz	"include"

.L.str.31:                              # @.str.31
	.asciz	"define"

.L.str.32:                              # @.str.32
	.asciz	"struct"

.L.str.33:                              # @.str.33
	.asciz	"union"

.L.str.38:                              # @.str.38
	.asciz	"synchronized"

.L.str.40:                              # @.str.40
	.asciz	"extern"

.L.str.41:                              # @.str.41
	.asciz	"sizeof"

.L.str.42:                              # @.str.42
	.asciz	"alignof"

.L.str.44:                              # @.str.44
	.asciz	"short"

.L.str.45:                              # @.str.45
	.asciz	"signed"

.L.str.48:                              # @.str.48
	.asciz	"friend"

.L.str.49:                              # @.str.49
	.asciz	"Interface"

.L.str.51:                              # @.str.51
	.asciz	"final"

.L.str.52:                              # @.str.52
	.asciz	"native"

.L.str.54:                              # @.str.54
	.asciz	"Quite a complex function."

.L.str.56:                              # @.str.56
	.asciz	"D:/Downloads/windows-7-critical-stop.wav"

.L.str.59:                              # @.str.59
	.asciz	"python \"D:/CStar/sound_play.py\" \""

.L.str.60:                              # @.str.60
	.asciz	"\""

.L.str.61:                              # @.str.61
	.asciz	"basic_string"

	.section	.rdata$_ZTISt12length_error,"dr",discard,_ZTISt12length_error
	.globl	_ZTISt12length_error            # @_ZTISt12length_error
	.p2align	3, 0x0
_ZTISt12length_error:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTSSt12length_error
	.quad	_ZTISt11logic_error

	.section	.rdata$_ZTSSt12length_error,"dr",discard,_ZTSSt12length_error
	.globl	_ZTSSt12length_error            # @_ZTSSt12length_error
_ZTSSt12length_error:
	.asciz	"St12length_error"

	.section	.rdata$_ZTISt11logic_error,"dr",discard,_ZTISt11logic_error
	.globl	_ZTISt11logic_error             # @_ZTISt11logic_error
	.p2align	3, 0x0
_ZTISt11logic_error:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
	.quad	_ZTSSt11logic_error
	.quad	_ZTISt9exception

	.section	.rdata$_ZTSSt11logic_error,"dr",discard,_ZTSSt11logic_error
	.globl	_ZTSSt11logic_error             # @_ZTSSt11logic_error
_ZTSSt11logic_error:
	.asciz	"St11logic_error"

	.section	.rdata$_ZTISt9exception,"dr",discard,_ZTISt9exception
	.globl	_ZTISt9exception                # @_ZTISt9exception
	.p2align	3, 0x0
_ZTISt9exception:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
	.quad	_ZTSSt9exception

	.section	.rdata$_ZTSSt9exception,"dr",discard,_ZTSSt9exception
	.globl	_ZTSSt9exception                # @_ZTSSt9exception
_ZTSSt9exception:
	.asciz	"St9exception"

	.section	.rdata,"dr"
.L.str.62:                              # @.str.62
	.asciz	"%d\n"

.L.str.63:                              # @.str.63
	.asciz	"%d"

.L.str.65:                              # @.str.65
	.asciz	"%c\n"

.L.str.68:                              # @.str.68
	.asciz	"%s"

.L.str.69:                              # @.str.69
	.asciz	"vector"

	.section	.ctors,"dw",unique,0
	.p2align	3, 0x0
	.quad	_GLOBAL__sub_I_test_posixstr.cpp
	.section	.drectve,"yni"
	.ascii	" -exclude-symbols:__clang_call_terminate"
	.section	.rdata$.refptr._ZTVSt12length_error,"dr",discard,.refptr._ZTVSt12length_error
	.p2align	3, 0x0
	.globl	.refptr._ZTVSt12length_error
.refptr._ZTVSt12length_error:
	.quad	_ZTVSt12length_error
	.section	.debug$S,"dr"
	.p2align	2, 0x0
	.long	4                               # Debug section magic
	.long	241
	.long	.Ltmp28-.Ltmp27                 # Subsection size
.Ltmp27:
	.short	.Ltmp30-.Ltmp29                 # Record length
.Ltmp29:
	.short	4353                            # Record kind: S_OBJNAME
	.long	0                               # Signature
	.byte	0                               # Object name
	.p2align	2, 0x0
.Ltmp30:
	.short	.Ltmp32-.Ltmp31                 # Record length
.Ltmp31:
	.short	4412                            # Record kind: S_COMPILE3
	.long	1                               # Flags and language
	.short	208                             # CPUType
	.short	21                              # Frontend version
	.short	1
	.short	2
	.short	0
	.short	21012                           # Backend version
	.short	0
	.short	0
	.short	0
	.asciz	"clang version 21.1.2 (https://github.com/llvm/llvm-project.git b708aea0bc7127adf4ec643660699c8bcdde1273)" # Null-terminated compiler version string
	.p2align	2, 0x0
.Ltmp32:
.Ltmp28:
	.p2align	2, 0x0
	.addrsig
	.addrsig_sym __gxx_personality_seh0
	.addrsig_sym __dtor_keywords
	.addrsig_sym _GLOBAL__sub_I_test_posixstr.cpp
	.addrsig_sym _Unwind_Resume
	.addrsig_sym keywords
	.addrsig_sym _ZTISt12length_error
	.addrsig_sym _ZTVN10__cxxabiv120__si_class_type_infoE
	.addrsig_sym _ZTSSt12length_error
	.addrsig_sym _ZTISt11logic_error
	.addrsig_sym _ZTSSt11logic_error
	.addrsig_sym _ZTISt9exception
	.addrsig_sym _ZTVN10__cxxabiv117__class_type_infoE
	.addrsig_sym _ZTSSt9exception
