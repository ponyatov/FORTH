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

## `( -- )` dump FVM state
def dump():
    print(f'\nD:{D}\nR:{R}\nW:{W}\n')

dump()

## stack operations

## `( -- cell )` push any Python object into @ref D data stack
def push(cell): D.append(cell); return D

## `( cell -- )` pop top element
## @param[in] idx optional stack index counting from stack top down
def pop(idx=0): return D.pop(-1 - idx)

## `( cell -- cell )` get top element w/o removing
def top(): return D[-1]

## `( ... -- ... n )` get stack depth: number of elements
def depth(): push(len(D)); return D

## `( ... -- )` clean the whole @ref D data stack
def clear(): D.clear(); return D

## `( a -- a a )` duplicate top element
def dup(): push(top()); return D

## `( a b -- a )` drop top element
def drop(): pop(); return D

## `( a b -- b a )` swap two elements
def swap(): a = pop(); b = pop(); push(a); push(b); return D

## `( a b -- a b a )` copy sub-top element
def over(): push(D[-2]); return D

## `( a b c -- b c a )` rotate cw
def rot(): push(pop(2))

## `( a b c -- c a b )` rorate ccw
def mrot(): D.insert(-2, pop())

## `( ... n -- ... D[n] )` pick n-th stack item counting from stack top down
def pick(): push(D[-1 - pop()])


# ## used libs
# import os, sys

# ## project generator

# ## create file
# def touch(name, content=None):
#     with open(name, 'w') as f:
#         if content is not None: print(content, file=f)

# ## create directory
# def mkdir(name, giti='!.gitignore'):
#     try: os.mkdir(name)
#     except FileExistsError: pass
#     with open(f'{name}/.gitignore','w') as g: print(giti, file=g)

# ## run `meld` using side project template
# def meld(file):
#     os.system(f'meld {file} ~/em/{file}')

# ## generic project structure
# dirs = ['.','.vscode','bin','doc','lib','inc','src','tmp','ref']
# for d in dirs: mkdir(d)

# def README():
#     touch('README.md',f'''# ![](doc/logo.png) `{APP}` {VERSION}
# ## {TITLE}\n
# (c) {AUTHOR} <<{EMAIL}>> {YEAR} {LICENSE}\n
# github: {GITHUB}''')

# README()

# vscode = ['extensions', 'settings', 'launch', 'tasks', 'c_cpp_properties']
# for v in vscode:
#     touch(f'.vscode/{v}.json')
# meld('.vscode')

# def apt():
#     touch('apt.Debian',f'''git make curl
# python3 python3-venv python3-autopep8 python3-ply''')
# apt();meld('apt.Debian')

# ## program run trace flag
# trace = True

# # core VM commands

# ## `( -- )` empty command: no nothing
# def nop():
#     if trace: print(nop)
# nop()


# def halt():
#     " ( -- ) stop system "
#     if trace:
#         print(halt)
#     sys.exit(0)


# # halt()

## Language Server Protocol
# from pygls.lsp.server import LanguageServer
