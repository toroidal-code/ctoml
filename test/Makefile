CFLAGS = -Wall -Wextra -pedantic -std=c++0x -g
SF = ../src
HF = ../src/include
BF = ../build

all : tomltest

main.o : main.cc $(HF)/toml.h
	$(CXX) $(CFLAGS) -c main.cc

tomltest : main.o
	$(CXX) main.o $(BF)/tomlvalue.o $(BF)/toml.o -o ctomltest

clean :
	rm main.o ctomltest
