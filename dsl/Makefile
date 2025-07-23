all:
	dune build

test-double-assert:
	dune exec _build/default/tests/test_double_assert.exe

test-simple:
	dune exec _build/default/tests/test_simple.exe

Makefile:
	@echo make $@

%:	force
	dune $@

.PHONY: all force
