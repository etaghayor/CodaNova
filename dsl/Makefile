all:
	dune build

test-codegen:
	dune exec ./test/test_codegen.exe

test-double-assert:
	dune exec _build/default/src/test_double_assert.exe

Makefile:
	@echo make $@

%:	force
	dune $@

.PHONY: all force
