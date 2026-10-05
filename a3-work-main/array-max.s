# Write the assembly code for the array_max function

.global array_max

.text

array_max:
    enter $0, $0

    # max = arr[0]
    movq (%rsi), %rax

    # i = 1
    movq $1, %rcx

loop:
    # if (i >= n), finish
    cmpq %rdi, %rcx
    jge done

    # get arr[i]
    movq (%rsi, %rcx, 8), %rdx

    # if (arr[i] <= max), skip update
    cmpq %rax, %rdx
    jle next

    # max = arr[i]
    movq %rdx, %rax

next:
    incq %rcx
    jmp loop

done:
    leave
    ret