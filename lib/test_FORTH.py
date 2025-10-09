import pytest
from FORTH import *

def test_always_passes(): assert True
def test_always_fails(): assert not False

## test @ref D data stack operations
class TestD:

    @pytest.fixture(autouse=True)
    def clear_stack(self): clear()
    # yield; D.clear() # optional clean after test

    class TestStack:

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

    class TestMath:

        def test_add(self):
            push(+123); push(-456); add(); assert D == [+123 + -456]

        def test_sub(self):
            push(+123); push(-456); add(); assert D == [+123 - -456]

        def test_mul(self):
            push(+123); push(-456); add(); assert D == [+123 * -456]

        def test_div(self):
            push(+123); push(-456); add(); assert D == [+123 / -456]

## test @ref R return stack operations
class TestR:
    def test_clear(self):
        assert R == []
