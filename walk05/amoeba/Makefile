# instructions for compiling test-amoeba.c on Linux

CFLAGS = -O3 -I/usr/local/include
LIBS = -lgsl -lgslcblas -lm
CC = gcc

all: test-amoeba

test-amoeba: test-amoeba.o 
	$(CC) $(CFLAGS) -o test-amoeba test-amoeba.o $(LIBS)

# you may need to put /usr/local/lib on your path:
# setenv LD_LIBRARY_PATH /usr/local/lib
# setenv LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH
