CWD = $(CURDIR)
TMP = $(CWD)/tmp

WGET = wget -c

CPU_CORES = $(shell grep processor /proc/cpuinfo |wc -l)

BIN = cfemm/bin/fmesher cfemm/bin/fpproc-test \
		cfemm/bin/fsolver cfemm/bin/hpproc-test \
		cfemm/bin/hsolver
		
.PHONY: all
all: $(BIN) doc spice qucs

$(BIN):
	cd cfemm ; cmake . && make

.PHONY: clean
clean:
	cd cfemm ; make clean

.PHONY: doc
doc: doc/manual42.pdf
doc/manual42.pdf:
	$(WGET) -O $@ http://www.femm.info/Archives/$@

SPICE = ngspice/bin/ngspice
.PHONY: spice
spice: $(SPICE)
ngspice/bin/ngspice: ../ngspice/configure
	rm -rf $(TMP)/ngspice ; mkdir $(TMP)/ngspice ; cd $(TMP)/ngspice ;\
	$(CWD)/../ngspice/configure --prefix=$(CWD)/ngspice &&\
	make -j$(CPU_CORES) && make install
../ngspice/configure:
	cd ../ngspice ; ./autogen.sh

packages:
	sudo apt install libxaw7-dev libqt4-dev

.PHONY: qucs	
qucs: qucs/bin/qucs-s
qucs/bin/qucs-s: tmp/qucs/README.md
	rm -rf tmp/qucs/build ; mkdir tmp/qucs/build ; cd tmp/qucs/build ;\
	cmake .. -DWITH_SPICE=ON -DCMAKE_INSTALL_PREFIX=$(CWD)/qucs &&\
	make -j$(CPU_CORES) && make install
tmp/qucs/README.md:
	git clone -o gh --depth=1 https://github.com/ra3xdh/qucs_s.git tmp/qucs
