CWD = $(CURDIR)
TMP = $(CWD)/tmp

WGET = wget -c

CPU_CORES = $(shell grep processor /proc/cpuinfo |wc -l)

BIN = cfemm/bin/fmesher cfemm/bin/fpproc-test \
		cfemm/bin/fsolver cfemm/bin/hpproc-test \
		cfemm/bin/hsolver
		
.PHONY: all
all: $(BIN) doc spice

$(BIN):
	cd cfemm ; cmake . && make

.PHONY: clean
clean:
	cd cfemm ; make clean

.PHONY: doc
doc: doc/manual42.pdf
doc/manual42.pdf:
	$(WGET) -O $@ http://www.femm.info/Archives/$@

SPICE = ../ngspice/configure ngspice/xz
.PHONY: spice
spice: $(SPICE)
../ngspice/configure:
	cd ../ngspice ; ./autogen.sh
ngspice/xz: ../ngspice/configure
	rm -rf $(TMP)/ngspice ; mkdir $(TMP)/ngspice ; cd $(TMP)/ngspice ;\
	$(CWD)/../ngspice/configure --prefix=$(CWD)/ngspice && make -j$(CPU_CORES)

packages:
	sudo apt install libxaw7-dev
