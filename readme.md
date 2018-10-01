### Description
The task was to implement a semaphore in x86_64 assembler. 

Functions:

void proberen(int32_t *semaphore, int32_t value); // decrement the semaphore

void verhogen(int32_t *semaphore, int32_t value); // increment the semaphore

uint64_t proberen_time(int32_t *semaphore, int32_t value); // decrement, and return the time it took


###  Compiling
`$ nasm -f elf64 -o semaphore.o semaphore.asm`