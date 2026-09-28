# A terminal calculator
#
# Reads a line of input, interprets it as a simple arithmetic expression,
# and prints the result. The input format is
# <long_integer> <operation> <long_integer>

# Make `main` accessible outside of this module
.global main

# Start of the code section
.text

main:
  # Function prologue
  enter $0, $0

  # Use scanf to retrieve and process a line of input
  # This block implements the following line of C code: 
  #   scanf("%ld %c %ld", &a, &op, &b);
  # Take a look at the man page for scanf and ask questions. You can also look 
  # at scanf_example.c
  movq $scanf_fmt, %rdi
  movq $a, %rsi
  movq $op, %rdx
  movq $b, %rcx
  xorb %al, %al
  call scanf

  movb op, %r8b # TODO: load the operation for comparisons
  movq a, %r9  # TODO: and the LHS
  movq b, %r10

  # TODO: Analyze operation and execute
  cmpb $'+', %r8b
  je add_case

  cmpb $'-', %r8b
  je sub_case

  cmpb $'*', %r8b
  je mul_case

  cmpb $'/', %r8b
  je div_case

  jmp unknown_op

  add_case:
  movq %r9, %r11
  addq %r10, %r11
  jmp print_result

  sub_case:
  movq %r9, %r11
  subq %r10, %r11
  jmp print_result

  mul_case:
  movq %r9, %r11
  imulq %r10, %r11
  jmp print_result

  div_case:
  cmpq $0, %r10
  je div_error

  movq %r9, %rax
  cqto
  idivq %r10

  movq %rax, %r11
  jmp print_result


  # TODO: Print result
  print_result:
  movq $output_fmt, %rdi
  movq %r11, %rsi
  xorb %al, %al
  call printf

  movq $0, %rax
  leave
  ret


  # TODO: Print error if operation cannot be (safely) performed
  unknown_op:
  movq $unknown_msg, %rdi
  xorb %al, %al
  call printf

  movq $1, %rax
  leave
  ret
 
  div_error:
  movq $div_error_msg, %rdi
  xorb %al, %al
  call printf

  movq $1, %rax
  leave
  ret




# Start of the data section
.data

output_fmt: 
  .asciz "%ld\n"
scanf_fmt: 
  .asciz "%ld %c %ld"  # TODO: modify as needed
unknown_msg:
  .asciz "Unknown operation\n"
div_error_msg:
  .asciz "Division error\n"

# "Slots" for scanf
a:  .quad 0
b:  .quad 0
op: .byte 0

