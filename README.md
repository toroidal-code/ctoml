Ctoml [![Build Status](https://travis-ci.org/toroidal-code/ctoml.png?branch=master)](https://travis-ci.org/toroidal-code/ctoml)
=====

A statically typed parser for @mojombo's TOML, written in C++11. Currently supports commit c6ea50d of the TOML spec, with a few exceptions:

* Unicode support for strings
* Null characters ('\0') in string literals

Usage
=====

```cxx
#include <ctoml/toml.h>

CToml toml;
toml.open("example.toml");
toml.parse();

// Get the value of a key
CTomlValue val = toml.get("potatoe.cake"); //or toml["potatoe.cake"]

// CTomlValues have types
if (val.type() == TOML_STRING) {
	printf("%s\n", val.as_string());
}

// But you can compare values without casting
if (val == "foobar") {
	// ....
}

// We can iterate through all the keys
for (auto key = toml.cbegin(); key != toml.cend(); ++key) {
	// Key names are stored as std::string
	printf("%s\n", key->first.c_str());
}
```

Build
=====

In order to use ctoml in your own projects, you need to build and install the library:

```sh
mkdir build && cd build  # this avoids poluting the root
cmake ..
make
sudo make install
```
The headers are installed to `/usr/local/include`, and the library to `/usr/local/lib`, so make sure these are sourced properly.  
Usually this involves either setting the env var as such `LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib`, or editing `/etc/ld.so.conf`
and running `ldconfig`.  
Don't forget to link against the library at compile time with `-lctoml`.



Command line tool
=================

A command line tool that parses TOML is provided (src/main.cc). It can take either a file or a single line string as input. If the parse is successful, it spews out every key and its value.

```
./ctomlparse -f "path/to/file"
./ctomlparse -l "single-line-TOML = 42"
```

Todo
====

* Needs more comprehensive tests
	* Test booleans
	* Test arrays
