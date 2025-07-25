all:
	dune build

test-app-assert:
	dune exec _build/default/tests/test_app_assert.exe

test-layered-assert:
	dune exec _build/default/tests/test_layered_assert.exe

test-double-assert:
	dune exec _build/default/tests/test_double_assert.exe

test-simple:
	dune exec _build/default/tests/test_simple.exe

Makefile:
	@echo make $@

%:	force
	dune $@

.PHONY: all force
