UNAME := $(shell uname)
ifeq ($(UNAME),Darwin)
	EXT := dylib
else
	EXT := so
endif

CFLAGS=-L.

all: libkunet libkunet_h5

libkunet: kunet.o
	nvcc $(CFLAGS) --shared --compiler-options -fPIC $^ -lcublas -lcurand -o $@.$(EXT)

libkunet_h5: kunet_h5.o
	nvcc $(CFLAGS) --shared --compiler-options -fPIC $^ -lhdf5 -lhdf5_hl -o $@.$(EXT)

kunet.o: kunet.cu kunet.h

kunet_h5.o: kunet_h5.cu kunet_h5.h kunet.h

%.o: %.cu
	nvcc -c $(CFLAGS) --compiler-options -fPIC $< -o $@

clean:
	-rm *.o *.$(EXT)
