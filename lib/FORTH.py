## project metainformation
APP     = 'FORTH'
TITLE   = 'minimal script language model in Python'
AUTHOR  = 'Dmitry Ponyatov'
EMAIL   = 'dponyatov@gmail.com'
LICENSE = 'MIT'
VERSION = '0.0.1'
YEAR    = 2025
GITHUB  = f'https://github.com/ponyatov/{APP}'

## used libs
import os, sys

## project generator

## create file
def touch(name, content=None):
    with open(name, 'w') as f:
        if content is not None: print(content, file=f)

## create directory
def mkdir(name, giti='!.gitignore'):
    try: os.mkdir(name)
    except FileExistsError: pass
    with open(f'{name}/.gitignore','w') as g: print(giti, file=g)

## run `meld` using side project template
def meld(file):
    os.system(f'meld {file} ~/em/{file}')

## generic project structure
dirs = ['.','.vscode','bin','doc','lib','inc','src','tmp','ref']
for d in dirs: mkdir(d)

def README():
    touch('README.md',f'''# ![](doc/logo.png) `{APP}` {VERSION}
## {TITLE}\n
(c) {AUTHOR} <<{EMAIL}>> {YEAR} {LICENSE}\n
github: {GITHUB}''')

README()

vscode = ['extensions', 'settings', 'launch', 'tasks', 'c_cpp_properties']
for v in vscode:
    touch(f'.vscode/{v}.json')
meld('.vscode')

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

