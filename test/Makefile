RAGEL=ragel

simple.jl: simple.rl
	$(RAGEL) -Y --goto-backend -G2 $< -o $@
