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
# Build the protobuf files
cd ../../proto
    mkdir -p protobuf
    cd protobuf
        wget https://github.com/protocolbuffers/protobuf/releases/download/v22.3/protoc-22.3-linux-x86_64.zip
        unzip protoc-22.3-linux-x86_64.zip
    cd ..
    export PATH=$(pwd)/protobuf/bin:$PATH
    protoc -I . *.proto --cpp_out=.
cd ..

# Build lilac
make
