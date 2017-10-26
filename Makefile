WGET = wget -c

BIN = cfemm/bin/fmesher cfemm/bin/fpproc-test \
		cfemm/bin/fsolver cfemm/bin/hpproc-test \
		cfemm/bin/hsolver
		
.PHONY: all
all: $(BIN) doc

$(BIN):
	cd cfemm ; cmake . && make

.PHONY: clean
clean:
	cd cfemm ; make clean

.PHONY: doc
doc: doc/manual42.pdf
doc/manual42.pdf:
	$(WGET) -O $@ http://www.femm.info/Archives/$@
