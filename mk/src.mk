# .mk files
MK += Makefile
MK += $(wildcard   mk/*.mk)
MK += $(wildcard   hw/*.mk)
MK += $(wildcard  cpu/*.mk)
MK += $(wildcard arch/*.mk)
MK += $(wildcard   os/*.mk)

# cmake files
CM += CMake* cmake/*.cmake

# C/C++
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)

# cross
C += $(wildcard   hw/src/*.c*) $(wildcard   hw/*/src/*.c*)
H += $(wildcard   hw/inc/*.h*) $(wildcard   hw/*/inc/*.h*)
C += $(wildcard  cpu/src/*.c*) $(wildcard  cpu/*/src/*.c*)
H += $(wildcard  cpu/inc/*.h*) $(wildcard  cpu/*/inc/*.h*)
C += $(wildcard arch/src/*.c*) $(wildcard arch/*/src/*.c*)
H += $(wildcard arch/inc/*.h*) $(wildcard arch/*/inc/*.h*)
C += $(wildcard   os/src/*.c*) $(wildcard   os/*/src/*.c*)
H += $(wildcard   os/inc/*.h*) $(wildcard   os/*/inc/*.h*)

# libs
C += $(wildcard lib/src/*.c*) $(wildcard lib/*/src/*.c*)
H += $(wildcard lib/inc/*.h*) $(wildcard lib/*/inc/*.h*)

# ini
F += $(wildcard lib/*.ini) $(wildcard lib/*.f)

# JavaScript
J += $(wildcard src/*.js)

# Python
P += $(wildcard src/*.py)
P += $(wildcard meta/*.py)
P += $(wildcard django/*.py)
P += $(wildcard django/tracker/settings.py)
P += $(wildcard django/task/*.py)

# Rust
R += $(wildcard src/*.rs)
