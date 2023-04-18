#!/bin/bash

# Clean the boringssl build directory
rm -rf boringssl/build/*
mkdir -p boringssl/install/lib

# Build boringssl
cd boringssl
mkdir -p build
cd build
cmake -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ..
make
make install DESTDIR=../install

# Install protobuf
sudo apt-get install -y protobuf-compiler

# Build the protobuf files
cd ../proto
protoc -I . *.proto --cpp_out=.

# Build the project
cd ../..
make
