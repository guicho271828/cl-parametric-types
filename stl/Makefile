
all: $(addsuffix .md,$(basename $(wildcard *.lisp)))

%.md: %.lisp
	awk -f documents.awk $< > $@

test: aaa.md
