            nop
            jmp forward
backward:
            bye
forward:
            jmp backward
forwardz:
            ret
            call backward
            lit 0x1234
\ Cp here
