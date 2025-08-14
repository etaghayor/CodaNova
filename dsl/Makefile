all:
	dune build

test-assert-app:
	dune exec _build/default/tests/test_assert_app.exe

test-shadowing:
	dune exec _build/default/tests/test_shadowing.exe

test-nested-assert:
	dune exec _build/default/tests/test_nested_assert.exe

test-double-assert:
	dune exec _build/default/tests/test_double_assert.exe

test-simple:
	dune exec _build/default/tests/test_simple.exe

test-leq-delay:
	dune exec _build/default/tests/test_leq_delay.exe

test-input-delay:
	dune exec _build/default/tests/test_input_delay.exe

test-output-delay:
	dune exec _build/default/tests/test_output_delay.exe


Makefile:
	@echo make $@

%:	force
	dune $@

.PHONY: all force
