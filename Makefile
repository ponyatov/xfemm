
BIN = cfemm/bin/fmesher cfemm/bin/fpproc-test \
		cfemm/bin/fsolver cfemm/bin/hpproc-test \
		cfemm/bin/hsolver

$(BIN):
	cd cfemm ; cmake . && make

clean:
	cd cfemm ; make clean
