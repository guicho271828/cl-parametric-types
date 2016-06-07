
all: $(addsuffix .md,$(basename $(wildcard *.lisp)))

%.md: %.lisp documents.awk
	mkdir -p ../doc/
	awk -f documents.awk $< > ../doc/$@

test: aaa.md
