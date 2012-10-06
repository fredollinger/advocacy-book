#$Id: Makefile,v 1.1.1.1 2006/06/18 22:45:29 bl0rg Exp $

MAIN = book
CC = latex
INSTALLDIR = /floppy
VIEWER = xdvi
EDITOR = vim
SPELL = ispell
PRINT = lpr
LETTER = letter
ZOOM = 2

all: 
	#cp -f /home/follinge/myaddress.tex .
	$(CC) $(MAIN).tex
	#dvips $(MAIN).dvi
txt:
	latex $(MAIN).tex
	latex $(MAIN).tex
	dvips $(MAIN).dvi
	ps2ascii $(MAIN).ps > $(MAIN).txt
cvs:
	picocvs commit
pdf:
	pdflatex $(MAIN).tex

notes: 
	$(CC) notes.tex
	dvips notes.dvi
wc: 
	 sed '/%/d' $(MAIN).tex| wc -w

ci: 
	ci -l $(MAIN).tex
	ci -l command.tex
	ci -l Makefile

clean: 
	rm -vf *.aux
	rm -vf *.log
	rm -vf *.dvi
	#rm -vf *.bak
	#rm -vf *.dvi
	rm -vrf $(MAIN)
	rm -vrf $(MAIN).txt
	rm -vrf $(MAIN).pdf
	rm -vrf $(MAIN).ps

install:
	mount $(INSTALLDIR)
	cp -rvf $(MAIN).pdf $(INSTALLDIR)
	umount $(INSTALLDIR)

view:
	$(VIEWER) $(MAIN).dvi

edit:
	$(EDITOR) $(MAIN).tex

spell: 
	$(SPELL) -t $(MAIN).tex

print: 
	$(PRINT) $(MAIN).ps

letter: 
	$(CC) $(LETTER).tex
	dvips $(LETTER).dvi

html: 
	tth $(MAIN).tex 
	sed 's/&#207;/I/g' $(MAIN).html  > $(MAIN).tmp
	sed 's/&#207;/\"I/g' $(MAIN).html | sed 's/&#214;/"O/g'  | sed 's/&#196;/"A/g' | sed 's/&#255;/"Y/g' |  sed 's/&#239;/\"I/g' | sed 's/&#228;/\"I/g'  | sed 's/&#203;/"E/g' > $(MAIN).tmp
	mv $(MAIN).tmp $(MAIN).html

rtf: 
	latex2rtf -Z1 $(MAIN).tex 
text: 
	lynx --dump $(MAIN).html > $(MAIN).txt
	mv $(MAIN).txt $(MAIN).tmp
	sed -n '/Fred Ollinger/,$$p' $(MAIN).tmp   > $(MAIN).txt
	sed '/_______________/q' $(MAIN).txt > $(MAIN).tmp	
	mv $(MAIN).tmp $(MAIN).txt
	
floppy:
	mount /floppy  
	rm -fv /floppy/$(MAIN).tgz 
	cd .. && tar -czvf /floppy/$(MAIN).tgz $(MAIN) 
	umount /floppy
table:
	pdflatex smelltable.tex

sub:
	pdflatex manuck.tex
	pdflatex manuck.tex
#$Id: Makefile,v 1.1.1.1 2006/06/18 22:45:29 bl0rg Exp $

single:
	$(CC) singlechap.tex
	dvips singlechap.dvi
