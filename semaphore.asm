section .text
    global proberen
    global verhogen
    global proberen_time
    extern get_os_time

;void proberen(int32_t *semaphore, int32_t value);
proberen:
    loop:
        cmp [rdi], esi
        jl loop            ; wait till we can try to decrement the semaphore

    mov ecx, esi            
    neg ecx                ; store negated value in ecx

    lock xadd [rdi], ecx   ; Decrement the semaphore

    cmp ecx, esi           ; If semaphore was >= than value, all is well
    jge prob_end

    lock add [rdi], esi    ; Otherwise, re-add the number we subtracted and 
    jmp loop               ; jump back to waiting

    prob_end:
    ret

;void verhogen(int32_t *semaphore, int32_t value);
verhogen:
    lock add [rdi], esi    ; Increment the semaphore
    ret

;uint64_t proberen_time(int32_t *semaphore, int32_t value);
proberen_time:
    push rdi
    push rsi               ; Store the parameters on the stack, 

    call get_os_time

    pop rsi
    pop rdi
    push rax               ; Restore parameters, then store get_os_time result
    push rax

    call proberen

    call get_os_time

    pop rdx
    
    pop rdx                ; load the first get_os_time result, then
    sub rax, rdx           ; subtract it from the second one

    ret