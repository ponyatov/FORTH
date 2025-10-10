import pytest
from FORTH import *

def test_always_passes(): assert True
def test_always_fails(): assert not False

class AnyTest:
    @pytest.fixture(autouse=True)
    def clear_stack(self): D.clear(); M.clear()
    # yield; D.clear() # optional clean after test

## test @ref D data stack operations
class TestStack(AnyTest):

    ## `( -- cell )`
    def test_push(self):
        push(1); assert D == [1]

    ## `( cell -- )`
    def test_pop(self):
        push(1); push(2); push(3); assert D == [1, 2, 3]
        assert pop() == 3; assert D == [1, 2]
        assert pop(1) == 1; assert D == [2]

    ## `( cell -- cell )`
    def test_top(self):
        push(1); assert top() == 1; assert D == [1]

    ## `CLEAR ( ... -- )`
    def test_clear(self):
        push(1); clear(); depth(); assert D == [0]

    ## `DUP ( a -- a a )`
    def test_dup(self):
        push(1); dup(); assert D == [1, 1]

    ## `DROP ( a b -- a )`
    def test_drop(self):
        push(1); push(2); drop(); assert D == [1]

    ## `PRESS ( a b -- b )`
    def test_press(self):
        push(1); push(2); press(); assert D == [2]

    ## `SWAP ( a b -- b a )`
    def test_swap(self):
        push(1); push(2); swap(); assert D == [2, 1]

    ## `OVER ( a b -- a b a )`
    def test_over(self):
        push(1); push(2); over(); assert D == [1, 2, 1]

    ## `ROT ( a b c -- b c a )`
    def test_rot(self):
        push(1); push(2); push(3); rot(); assert D == [2, 3, 1]

    ## `-ROT ( a b c -- c a b )`
    def test_mrot(self):
        push(1); push(2); push(3); mrot(); assert D == [3, 1, 2]

    ## `PICK ( ... n -- ... D[n] )`
    def test_pick(self):
        push(1); push(2); push(3); rot(); pick(); assert D == [2, 3, 2]

    ## `DEPTH ( ... -- ... n )`
    def test_depth(self):
        assert depth() == [0]
        push(1); push(2); push(3)
        assert depth() == [0, 1, 2, 3, 4] # with previous and new depth's

## test integer math
class TestMath(AnyTest):

    ## `+ ( a b -- a+b )`
    def test_add(self):
        push(+12); push(-34); add(); assert D == [+12 + -34] # -22

    ## `- ( a b -- a-b )`
    def test_sub(self):
        push(+12); push(-34); sub(); assert D == [+12 - -34] # +46

    ## `* ( a b -- a*b )`
    def test_mul(self):
        push(+12); push(-34); mul(); assert D == [+12 * -34] # -408

    ## `/ ( a b -- a/b )`
    def test_div(self):
        push(+12); push(-34); div(); assert D == [+12 // -34] # -1

    ## `% ( a b -- a%b )`
    def test_mod(self):
        push(+12); push(-34); mod(); assert D == [+12 % -34] # -22

## test @ref M ops
class TestMemory(AnyTest):

    def test_empty(self): assert M == []

    ## `M++ = cell`
    def test_compile(self):
        push(1); compile(); push(2); compile(); assert M == [1, 2]

    def test_fetch(self):
        self.test_compile()
        push(1); fetch(); assert D == [2]

    def test_store(self):
        self.test_compile()
        push(3); push(1); store(); assert M == [1, 3]

## test @ref R return stack operations
class TestR(AnyTest):

    ## `M:[]`
    def test_clear(self):
        assert R == []

## test FORTH Vocabulary
class TestVocabulary(AnyTest):

    def test_voc(self):
        assert W['NOP'] == nop; assert W['BYE'] == bye

    def test_word(self):
        word(); assert D == ['NOP']

    def test_find(self):
        word(); find(); assert top() == nop

    def test_exec(self):
        word(); find(); exec(); assert D == []

## test FORTH @ref lexer
class TestLexer:

    def test_empty(self):
        lexer.input(''); assert list(lexer) == []

    def test_spaces(self):
        lexer.input(' \t\r\n'); assert list(lexer) == []

    def test_items(self):
        lexer.input(' 12 +34 -56 abc %$#')
        assert [t.value for t in lexer] == [12, 34, -56, 'abc', '%$#']

    def test_linecount(self):
        lexer.lineno = 1
        self.test_spaces(); assert lexer.lineno == 2
