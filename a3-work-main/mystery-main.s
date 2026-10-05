# Write the assembly code for the main function of the mystery program
.global main

.text

main:
    enter $16, $0

    # if (argc != 3)
    cmpl $3, %edi
    jne error

    # Save argv
    movq %rsi, -8(%rbp)

    # a = atol(argv[1])
    movq -8(%rbp), %rax
    movq 8(%rax), %rdi
    call atol
    movq %rax, -16(%rbp)

    # b = atol(argv[2])
    movq -8(%rbp), %rax
    movq 16(%rax), %rdi
    call atol

    # result = crunch(a, b)
    movq %rax, %rsi
    movq -16(%rbp), %rdi
    call crunch

    # Check result
    cmpq $0, %rax
    jl print_hat
    je print_tea
    jmp print_beer

print_hat:
    movq $hat_msg, %rdi
    call puts
    jmp success

print_tea:
    movq $tea_msg, %rdi
    call puts
    jmp success

print_beer:
    movq $beer_msg, %rdi
    call puts
    jmp success

error:
    movq $error_msg, %rdi
    call puts

    movq $1, %rax
    leave
    ret

success:
    movq $0, %rax
    leave
    ret


.data

error_msg:
    .asciz "Two arguments required."
hat_msg:
    .asciz "hat"
tea_msg:
    .asciz "tea"
beer_msg:
    .asciz "beer"
