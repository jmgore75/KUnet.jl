UNAME := $(shell uname)
ifeq ($(UNAME),Darwin)
	EXT := dylib
else
	EXT := so
endif

#CFLAGS=-L.
CFLAGS=-O2

libkunet: drop.o logp.o logploss.o param.o softloss.o xentloss.o percloss.o kperceptron.o cumatrix.o
	nvcc $(CFLAGS) --shared --compiler-options -fPIC $^ -lcublas -lcurand -o $@.$(EXT)

%.o: %.cu kunet.h
	nvcc -c $(CFLAGS) --compiler-options -fPIC $< -o $@

clean:
	-rm *.o *.$(EXT)
