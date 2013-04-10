CFLAGS = -Wall -Wextra -pedantic -std=c++0x -g
SF = ../src
HF = ../src/include

all : toml

main.o : $(SF)/main.cc $(HF)/toml.h
	$(CXX) $(CFLAGS) -c $(SF)/main.cc

tomlvalue.o : $(SF)/tomlvalue.cc $(HF)/tomlvalue.h
	$(CXX) $(CFLAGS) -c $(SF)/tomlvalue.cc

toml.o : $(SF)/toml.cc $(HF)/toml.h $(HF)/tomlvalue.h
	$(CXX) $(CFLAGS) -c $(SF)/toml.cc

toml : main.o tomlvalue.o toml.o
	$(CXX) main.o tomlvalue.o toml.o -o ctoml

clean :
	rm toml.o main.o tomlvalue.o ctoml
