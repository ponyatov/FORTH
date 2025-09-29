# .mk files
MK += Makefile $(wildcard mk/*.mk)

# cmake files
CM += CMake* $(wildcard cmake/*.cmake)

# C/C++
C  += $(wildcard src/*.c*)
H  += $(wildcard inc/*.h*)

# ini
S  += $(wildcard lib/*.ini) $(wildcard lib/*.f)

# JavaScript
T += $(wildcard src/*.ts)
J += $(wildcard src/*.js)

# Python
P += $(wildcard src/*.py) $(wildcard lib/*.py)
