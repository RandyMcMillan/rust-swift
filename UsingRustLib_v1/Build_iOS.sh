#!/bin/bash

pushd `pwd`
echo pwd=`pwd`
ls

LIB_IOS_X86_64=target/x86_64-apple-ios/debug/libSwift_UsingRustLib_v1.a;
LIB_IOS_ARM_64=target/aarch64-apple-ios/debug/libSwift_UsingRustLib_v1.a;
LIB_IOS_FAT=target/libSwift_UsingRustLib_v1.a;
LIB_HEADER=target/UsingRust_v1.h;
CARGO=$(which cargo)
LIPO=$(which lipo)
$CARGO build --target aarch64-apple-ios;
#$CARGO build --bins --target aarch64-apple-ios;
$LIPO -info $LIB_IOS_ARM_64;

$CARGO build --target x86_64-apple-ios;
#$CARGO build --bins --target x86_64-apple-ios;
$LIPO -info $LIB_IOS_X86_64;

$LIPO -create $LIB_IOS_X86_64 $LIB_IOS_ARM_64 -output $LIB_IOS_FAT;
$LIPO -info $LIB_IOS_FAT;

CBINDGEN=$(which cbindgen) && CBINDGEN -l C -o $LIB_HEADER;

cp $LIB_IOS_FAT ../UsingRust_v1/RustLibrary/
cp $LIB_HEADER ../UsingRust_v1/RustLibrary/
