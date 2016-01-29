DICDIR = ./dictionaries

ORIDIR = $(DICDIR)/original
ORIWBR = $(ORIDIR)/swathdic.tri
ORIHYP = $(ORIDIR)/hyph-th.tex

PATDIR = $(DICDIR)/patches
PATWBR = $(PATDIR)/word-breaks
PATHYP = $(PATDIR)/hyphenation

FIXDIR = $(DICDIR)/fixed
FIXWBR = $(FIXDIR)/wbr.tri
FIXWBE = $(FIXDIR)/wbr.exc
FIXHYP = $(FIXDIR)/hyp.tex

dictionaries: $(FIXHYP) $(FIXWBR) $(FIXWBE)

$(FIXHYP): $(PATHYP)
	grep --invert-match '^%' $(ORIHYP) > $(FIXHYP)
	echo '\hyphenation{%' >> $(FIXHYP)
	tr " " "-" < $(PATHYP) >> $(FIXHYP)
	echo '}' >> $(FIXHYP)

NEWWORDS := $(shell mktemp -u)

$(FIXWBR): $(PATWBR)
	cp $(ORIWBR) $(FIXWBR)
	grep --invert-match " " $(PATWBR) > $(NEWWORDS) || true
	trietool-0.2 $(basename $(FIXWBR)) \
	  add-list --encoding UTF-8 $(NEWWORDS)
	rm $(NEWWORDS)

$(FIXWBE): $(PATWBR)
	grep " " $(PATWBR) > $(FIXWBE) || true
