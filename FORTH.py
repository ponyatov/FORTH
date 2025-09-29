## used libs
import sys

## project metainformation
APP     = 'FORTH'
TITLE   = 'minimal script language model in Python'
AUTHOR  = 'Dmitry Ponyatov'
EMAIL   = 'dponyatov@gmail.com'
LICENSE = 'MIT'
VERSION = '0.0.1'
YEAR    = 2025

## Data stack
D = []

## Return stack
R = []

## vocabulary Words
W = {}

## program run trace flag
trace = True

# core VM commands

## `( -- )` empty command: no nothing
def nop():
    if trace: print(nop)
nop()


def halt():
    " ( -- ) stop system "
    if trace:
        print(halt)
    sys.exit(0)


# halt()

