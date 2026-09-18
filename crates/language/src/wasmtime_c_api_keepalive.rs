//! Keeps the wasmtime C API symbols alive through link-time optimization.
//!
//! Tree-sitter's bundled C code (`wasm_store.c`) calls the wasmtime C API, whose
//! implementation lives in the `wasmtime-c-api-impl` crate as `#[no_mangle]
//! extern "C"` functions. Nothing in the Rust dependency graph calls them --
//! only tree-sitter's C objects do, and `cc` compiles those outside the LTO
//! unit. Under `lto = "thin"` LLVM therefore internalizes and drops the
//! definitions, and the linker resolves the C references to RVA 0 instead of
//! erroring. The first `WasmStore::new` (see `with_parser`) then calls through a
//! null pointer relocated to the image base and dies with a DEP access
//! violation.
//!
//! Tree-sitter's own `_use_wasmtime` hook only forces Cargo to link the crate;
//! it is dead code, so LTO removes the reference along with everything else.
//! Taking each address in a `#[used]` static gives LLVM a live reference inside
//! the LTO unit, so the definitions survive.

/// Declares each symbol and stores its address, so that LTO cannot drop it.
///
/// The declared signatures are deliberately empty: these are C-ABI symbols that
/// link by name, and nothing here ever calls them.
macro_rules! keep_alive {
    ($($symbol:ident),+ $(,)?) => {
        unsafe extern "C" {
            $(fn $symbol();)+
        }

        #[used]
        static KEEP_WASMTIME_C_API: &[unsafe extern "C" fn()] = &[$($symbol),+];
    };
}

keep_alive!(
    wasm_byte_vec_delete,
    wasm_engine_delete,
    wasm_exporttype_name,
    wasm_exporttype_vec_delete,
    wasm_externtype_as_memorytype_const,
    wasm_functype_delete,
    wasm_functype_new,
    wasm_globaltype_delete,
    wasm_globaltype_new,
    wasm_importtype_name,
    wasm_importtype_type,
    wasm_importtype_vec_delete,
    wasm_memorytype_delete,
    wasm_memorytype_new,
    wasm_tabletype_delete,
    wasm_tabletype_new,
    wasm_trap_delete,
    wasm_trap_message,
    wasm_valtype_new,
    wasm_valtype_vec_new,
    wasm_valtype_vec_new_empty,
    wasmtime_caller_context,
    wasmtime_engine_clone,
    wasmtime_error_delete,
    wasmtime_error_message,
    wasmtime_func_call,
    wasmtime_func_call_unchecked,
    wasmtime_func_new_unchecked,
    wasmtime_global_new,
    wasmtime_instance_export_nth,
    wasmtime_instance_new,
    wasmtime_memory_data,
    wasmtime_memory_data_size,
    wasmtime_memory_grow,
    wasmtime_memory_new,
    wasmtime_memorytype_minimum,
    wasmtime_module_delete,
    wasmtime_module_exports,
    wasmtime_module_imports,
    wasmtime_module_new,
    wasmtime_store_context,
    wasmtime_store_delete,
    wasmtime_store_new,
    wasmtime_table_get,
    wasmtime_table_grow,
    wasmtime_table_new,
    wasmtime_table_set,
    wasmtime_trap_new,
);
