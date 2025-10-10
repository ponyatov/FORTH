## project metainformation
APP = 'FORTH'
TITLE = 'minimal FORTH language model in Python'
AUTHOR = 'Dmitry Ponyatov'
EMAIL = 'dponyatov@gmail.com'
TELEGRAM = '@dponyatov'
LICENSE = 'MIT'
VERSION = '0.0.1'
YEAR = 2025
GITHUB = f'https://github.com/ponyatov/{APP}'

## FVM memory

D = [] ## Data stack
R = [] ## Return stack
W = {} ## vocabulary Words
M = [] ## main Memory

## `DUMP ( -- )` dump FVM state
def dump(): print(f'\nD:{D}\nR:{R}\nW:{W}\nM:{M}')

## Stack Operations

## `( -- cell )` push any Python object into @ref D data stack
def push(cell): D.append(cell)

## `( cell -- )` pop top element
## @param[in] idx optional stack index counting from stack top down
def pop(idx=0): return D.pop(-1 - idx)

## `( cell -- cell )` get top element w/o removing
def top(idx=0): return D[-1 - idx]

## `CLEAR ( ... -- )` clean the whole @ref D data stack
def clear(): D.clear()

## `DUP ( a -- a a )` duplicate top element
def dup(): push(top())

## `DROP ( a b -- a )` drop top element
def drop(): pop()

## `PRESS ( a b -- b )` drop sub-top element
def press(): pop(1)

## `SWAP ( a b -- b a )` swap two elements
def swap(): push(pop(1))

## `OVER ( a b -- a b a )` copy sub-top element
def over(): push(D[-2])

## `ROT ( a b c -- b c a )` rotate cw
def rot(): push(pop(2))

## `-ROT ( a b c -- c a b )` rorate ccw
def mrot(): D.insert(-2, pop())

## `PICK ( ... n -- ... D[n] )` pick n-th stack item counting top down (<-left)
def pick(): push(D[-1 - pop()])

## `DEPTH ( ... -- ... n )` get stack depth: number of elements
def depth(): push(len(D)); return D

## Arithmetic Operations

## `+ ( a b -- a+b )`
def add(): b = pop(); a = pop(); push(a + b)

## `- ( a b -- a-b )`
def sub(): b = pop(); a = pop(); push(a - b)

## `* ( a b -- a*b )`
def mul(): b = pop(); a = pop(); push(a * b)

## `/ ( a b -- a/b )` integer division
def div(): b = pop(); a = pop(); push(a // b)

## `% ( a b -- a%b )` modulo remainder
def mod(): b = pop(); a = pop(); push(a % b)

## Memory Operations

# `, ( cell -- )` append cell to end of allocated @ref M
def compile(): M.append(pop())

## `@ ( addr -- cell )` fetch object from @ref M using integer index
def fetch(): push(M[pop()])

## `! ( cell addr -- )` store object to @ref M
def store(): addr = pop(); M[addr] = pop()

## System Control

import sys, time

## `NOP ( -- )` do nothing command
def nop(): pass

## `BYE ( -- )` terminate system (poweroff of deep sleep)
def bye(): print(); sys.exit(0)

## `HALT ( -- )` stop system until external event happens (sleep mode)
def halt():
    while True: time.sleep(0.1)

## Vocabulary

## fill vocabulary (most simple version w/o attributes & @ref M memory)
W['NOP'] = nop; W['BYE'] = bye; W

## `WORD ( -- name )` get word name from source code stream (lexer)
def word(): push('NOP') # lexer()

## `FIND ( name:str -- item|none )` find item in vocabulary by it's name
def find(): push(W.get(pop(), None))

## `EXEC ( item -- )` execute (found) item on a stack top
def exec(): pop()()

## Lexer

import ply.lex as lex

## token types: integer, floating point number, and word name
tokens = ['INT', 'NUM', 'WORD']

## drop spaces
t_ignore = '[ \t\r]'

## line comments
t_ignore_comment = r'\\.*'

## count lines using EOL chars as delimiter
def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)

## integer number rule: regexp + token value conversion from string
def t_INT(t):
    r'[+\-]?[0-9]+'
    t.value = int(t.value); return t

## group of any non-space chars
def t_WORD(t):
    r'[^ \t\r\n]+'
    return t

## lexer error callback
def t_error(t): raise SyntaxError(t)

## build lexer from defined `t_` rules
lexer = lex.lex()

## REPL

## `INPUT ( -- )` get next source code string or user input
## @details into @ref PAD in case of low-level FORTH system
def input_(): lexer.input(input(f'{lexer.lineno}> '))

## `TOKEN ( -- token|None )` call lexer to get next token
def token(): push(lexer.token())

## `REPL ( -- )` run CLI loop
def REPL():
    while True:
        dump()
        try: input_()
        except EOFError: bye()
        except KeyboardInterrupt: bye()
        while True:
            token()
            if top() is None: drop(); break

## run @ref REPL if was started with as script: bin/python3 lib/FORTH.py
if __name__ == '__main__': REPL()
