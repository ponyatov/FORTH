HW  = _
CPU = i5-3470T
RUN = $^ $(F)

TCC   = $(CXX)
TDUMP = objdump
TCOPY = objcopy

OBJ += tmp/$(MODULE).lexer.o tmp/$(MODULE).parser.o
