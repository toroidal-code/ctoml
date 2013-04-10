all: toml

toml:
	cd build && make && cd ..

test: toml
	cd test && make && cd ..

clean:
	cd test && make clean && cd .. && cd build && make clean && cd ..
