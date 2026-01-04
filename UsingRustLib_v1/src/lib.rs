#![allow(non_snake_case)]
#![allow(non_camel_case_types)]

use std::ffi::CString;
use std::os::raw::c_char;
use gnostr::version;

#[no_mangle]
pub extern "C" fn fStringFromRustLibrary() -> *const c_char {

	let oOutput: CString = CString::new("String from Rust library").unwrap();
	return oOutput.into_raw();
}
#[no_mangle]
pub extern "C" fn fStartRelay() -> *const c_char {

	let oOutput: CString = CString::new("fStartRelay").unwrap();
	return oOutput.into_raw();
}

#[no_mangle]
pub extern "C" fn fGnostrVersion() -> *const c_char {
    let version_string = version();
    let c_string = CString::new(version_string).unwrap();
    c_string.into_raw()
}
