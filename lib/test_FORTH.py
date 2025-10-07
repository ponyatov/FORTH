import pytest
from FORTH import *

def test_always_passes(): assert True
def test_always_fails(): assert not False

## test @ref D data stack operations
class TestD:

    @pytest.fixture(autouse=True)
    def clear_stack(self): clear()
    # yield; D.clear() # optional clean after test

    def test_push(self): assert push(1) == [1]; assert D == [1]
    def test_pop(self): push(1); assert pop() == 1; assert D == []
    def test_top(self): push(1); assert top() == 1; assert D == [1]

    def test_clear(self): clear(); depth(); assert D == [0]

    def test_depth(self):
        assert depth() == [0]
        push(1); push(2); push(3)
        assert depth() == [0, 1, 2, 3, 4] # with previous and new depth's

    def test_dup(self):
        push(1); dup(); assert D == [1, 1]

    def test_drop(self):
        push(1); push(2); drop(); assert D == [1]

    def test_swap(self):
        push(1); push(2); swap(); assert D == [2, 1]

    def test_over(self):
        push(1); push(2); over(); assert D == [1, 2, 1]

## test @ref R return stack operations
class TestR:
    def test_clear(self):
        assert R == []
