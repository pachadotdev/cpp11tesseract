// Generated by cpp11: do not edit by hand
// clang-format off

#include "cpp11tesseract_types.h"
#include "cpp11/declarations.hpp"
#include <R_ext/Visibility.h>

// cpp11tesseract.cpp
int tesseract_major_version();
extern "C" SEXP _cpp11tesseract_tesseract_major_version() {
  BEGIN_CPP11
    return cpp11::as_sexp(tesseract_major_version());
  END_CPP11
}
// cpp11tesseract.cpp
list tesseract_config();
extern "C" SEXP _cpp11tesseract_tesseract_config() {
  BEGIN_CPP11
    return cpp11::as_sexp(tesseract_config());
  END_CPP11
}
// cpp11tesseract.cpp
TessPtr tesseract_engine_internal(strings datapath, strings language, strings confpaths, strings opt_names, strings opt_values);
extern "C" SEXP _cpp11tesseract_tesseract_engine_internal(SEXP datapath, SEXP language, SEXP confpaths, SEXP opt_names, SEXP opt_values) {
  BEGIN_CPP11
    return cpp11::as_sexp(tesseract_engine_internal(cpp11::as_cpp<cpp11::decay_t<strings>>(datapath), cpp11::as_cpp<cpp11::decay_t<strings>>(language), cpp11::as_cpp<cpp11::decay_t<strings>>(confpaths), cpp11::as_cpp<cpp11::decay_t<strings>>(opt_names), cpp11::as_cpp<cpp11::decay_t<strings>>(opt_values)));
  END_CPP11
}
// cpp11tesseract.cpp
TessPtr tesseract_engine_set_variable(TessPtr ptr, const char * name, const char * value);
extern "C" SEXP _cpp11tesseract_tesseract_engine_set_variable(SEXP ptr, SEXP name, SEXP value) {
  BEGIN_CPP11
    return cpp11::as_sexp(tesseract_engine_set_variable(cpp11::as_cpp<cpp11::decay_t<TessPtr>>(ptr), cpp11::as_cpp<cpp11::decay_t<const char *>>(name), cpp11::as_cpp<cpp11::decay_t<const char *>>(value)));
  END_CPP11
}
// cpp11tesseract.cpp
logicals validate_params(strings params);
extern "C" SEXP _cpp11tesseract_validate_params(SEXP params) {
  BEGIN_CPP11
    return cpp11::as_sexp(validate_params(cpp11::as_cpp<cpp11::decay_t<strings>>(params)));
  END_CPP11
}
// cpp11tesseract.cpp
list engine_info_internal(TessPtr ptr);
extern "C" SEXP _cpp11tesseract_engine_info_internal(SEXP ptr) {
  BEGIN_CPP11
    return cpp11::as_sexp(engine_info_internal(cpp11::as_cpp<cpp11::decay_t<TessPtr>>(ptr)));
  END_CPP11
}
// cpp11tesseract.cpp
strings print_params(std::string filename);
extern "C" SEXP _cpp11tesseract_print_params(SEXP filename) {
  BEGIN_CPP11
    return cpp11::as_sexp(print_params(cpp11::as_cpp<cpp11::decay_t<std::string>>(filename)));
  END_CPP11
}
// cpp11tesseract.cpp
strings get_param_values(TessPtr api, strings params);
extern "C" SEXP _cpp11tesseract_get_param_values(SEXP api, SEXP params) {
  BEGIN_CPP11
    return cpp11::as_sexp(get_param_values(cpp11::as_cpp<cpp11::decay_t<TessPtr>>(api), cpp11::as_cpp<cpp11::decay_t<strings>>(params)));
  END_CPP11
}
// cpp11tesseract.cpp
strings ocr_raw(raws input, TessPtr ptr, bool HOCR);
extern "C" SEXP _cpp11tesseract_ocr_raw(SEXP input, SEXP ptr, SEXP HOCR) {
  BEGIN_CPP11
    return cpp11::as_sexp(ocr_raw(cpp11::as_cpp<cpp11::decay_t<raws>>(input), cpp11::as_cpp<cpp11::decay_t<TessPtr>>(ptr), cpp11::as_cpp<cpp11::decay_t<bool>>(HOCR)));
  END_CPP11
}
// cpp11tesseract.cpp
strings ocr_file(std::string file, TessPtr ptr, bool HOCR);
extern "C" SEXP _cpp11tesseract_ocr_file(SEXP file, SEXP ptr, SEXP HOCR) {
  BEGIN_CPP11
    return cpp11::as_sexp(ocr_file(cpp11::as_cpp<cpp11::decay_t<std::string>>(file), cpp11::as_cpp<cpp11::decay_t<TessPtr>>(ptr), cpp11::as_cpp<cpp11::decay_t<bool>>(HOCR)));
  END_CPP11
}
// cpp11tesseract.cpp
data_frame ocr_raw_data(raws input, TessPtr ptr);
extern "C" SEXP _cpp11tesseract_ocr_raw_data(SEXP input, SEXP ptr) {
  BEGIN_CPP11
    return cpp11::as_sexp(ocr_raw_data(cpp11::as_cpp<cpp11::decay_t<raws>>(input), cpp11::as_cpp<cpp11::decay_t<TessPtr>>(ptr)));
  END_CPP11
}
// cpp11tesseract.cpp
data_frame ocr_file_data(const std::string & file, TessPtr ptr);
extern "C" SEXP _cpp11tesseract_ocr_file_data(SEXP file, SEXP ptr) {
  BEGIN_CPP11
    return cpp11::as_sexp(ocr_file_data(cpp11::as_cpp<cpp11::decay_t<const std::string &>>(file), cpp11::as_cpp<cpp11::decay_t<TessPtr>>(ptr)));
  END_CPP11
}

extern "C" {
static const R_CallMethodDef CallEntries[] = {
    {"_cpp11tesseract_engine_info_internal",          (DL_FUNC) &_cpp11tesseract_engine_info_internal,          1},
    {"_cpp11tesseract_get_param_values",              (DL_FUNC) &_cpp11tesseract_get_param_values,              2},
    {"_cpp11tesseract_ocr_file",                      (DL_FUNC) &_cpp11tesseract_ocr_file,                      3},
    {"_cpp11tesseract_ocr_file_data",                 (DL_FUNC) &_cpp11tesseract_ocr_file_data,                 2},
    {"_cpp11tesseract_ocr_raw",                       (DL_FUNC) &_cpp11tesseract_ocr_raw,                       3},
    {"_cpp11tesseract_ocr_raw_data",                  (DL_FUNC) &_cpp11tesseract_ocr_raw_data,                  2},
    {"_cpp11tesseract_print_params",                  (DL_FUNC) &_cpp11tesseract_print_params,                  1},
    {"_cpp11tesseract_tesseract_config",              (DL_FUNC) &_cpp11tesseract_tesseract_config,              0},
    {"_cpp11tesseract_tesseract_engine_internal",     (DL_FUNC) &_cpp11tesseract_tesseract_engine_internal,     5},
    {"_cpp11tesseract_tesseract_engine_set_variable", (DL_FUNC) &_cpp11tesseract_tesseract_engine_set_variable, 3},
    {"_cpp11tesseract_tesseract_major_version",       (DL_FUNC) &_cpp11tesseract_tesseract_major_version,       0},
    {"_cpp11tesseract_validate_params",               (DL_FUNC) &_cpp11tesseract_validate_params,               1},
    {NULL, NULL, 0}
};
}

extern "C" attribute_visible void R_init_cpp11tesseract(DllInfo* dll){
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
  R_forceSymbols(dll, TRUE);
}
