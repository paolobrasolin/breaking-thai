
DICDIR = ./dictionaries
ORIDIR = $(DICDIR)/original
PATDIR = $(DICDIR)/patches
FIXDIR = $(DICDIR)/fixed
ORIWBR = $(ORIDIR)/swathdic.tri
ORIHYP = $(ORIDIR)/hyph-th.tex
PATWBR = $(PATDIR)/word-breaks
PATHYP = $(PATDIR)/hyphenation
FIXWBR = $(FIXDIR)/wbr.tri
FIXHYP = $(FIXDIR)/hyp.tex


#.PHONY: clean

$(FIXHYP): $(PATHYP)
	grep --invert-match '^%' $(ORIHYP) > $(FIXHYP)
	echo '\hyphenation{%' >> $(FIXHYP)
	cat $(PATHYP) >> $(FIXHYP)
	echo '}' >> $(FIXHYP)

$(FIXWBR): $(PATWBR)
	cp $(ORIWBR) $(FIXWBR)

dictionaries: $(FIXHYP) $(FIXWBR)



#swath -b "|" -u u,u <&0 | ./hyphenate -b="-"



