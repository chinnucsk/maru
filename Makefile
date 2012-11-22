# -*- mode: Makefile; fill-column: 80; comment-column: 75; -*-

ERL = $(shell which erl)

ERLFLAGS= -pa $(CURDIR)/.eunit -pa $(CURDIR)/ebin -pa $(CURDIR)/*/ebin

REBAR=rebar

MARU_PLT=$(CURDIR)/.depsolver_plt

.PHONY: dialyzer typer clean distclean

compile:
	@rebar get-deps compile

$(MARU_PLT):
	dialyzer --output_plt $(MARU_PLT) --build_plt \
		--apps erts kernel stdlib crypto public_key -r deps --fullpath

dialyzer: $(MARU_PLT)
	dialyzer --plt $(MARU_PLT) -pa deps/* --src src

typer: $(MARU_PLT)
	typer --plt $(MARU_PLT) -r ./src

clean:
	$(REBAR) clean

distclean: clean
	rm $(MARU_PLT)
	rm -rvf $(CURDIR)/deps/*
