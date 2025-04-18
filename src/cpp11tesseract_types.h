// Include R's C API for Windows to intercept problematic symbols
#ifdef _WIN32
// Include R headers first
#include <R.h>
#include <Rinternals.h>

// Use a namespace to avoid conflicts
namespace tesseract_r_wrapper {
// Safe versions that don't terminate R
inline void safe_abort() {
  REprintf("Internal error detected in tesseract (abort call intercepted)\n");
}

inline void safe_exit(int status) {
  REprintf("Exit requested with status %d (intercepted)\n", status);
}

inline int safe_rand() { return 0; }
inline void safe_srand(unsigned int seed) {}
}  // namespace tesseract_r_wrapper

// Only include the C++ header interceptors after defining our safe functions
#include <cstdlib>
#include <iostream>

// Override problematic functions after including standard headers
#ifdef abort
#undef abort
#endif
#define abort tesseract_r_wrapper::safe_abort

#ifdef exit
#undef exit
#endif
#define exit(x) tesseract_r_wrapper::safe_exit(x)

#ifdef rand
#undef rand
#endif
#define rand tesseract_r_wrapper::safe_rand

#ifdef srand
#undef srand
#endif
#define srand(x) tesseract_r_wrapper::safe_srand(x)

// Redirect cout/cerr
#define cerr \
  if (0) std::cerr
#define cout \
  if (0) std::cout

#endif  // _WIN32

// On macOS, try multiple include paths
#if __APPLE__
#if __has_include(<leptonica/allheaders.h>)
#include <leptonica/allheaders.h>
#elif __has_include(<allheaders.h>)
#include <allheaders.h>
#else
#error "Could not find allheaders.h"
#endif
#else
// On other platforms
#include <allheaders.h>  // leptonica
#endif

#include <tesseract/baseapi.h>  // tesseract

#include <cpp11.hpp>
#include <list>
#include <memory>
#include <string>
#include <vector>

#include "tesseract_config.h"

inline void tess_finalizer(tesseract::TessBaseAPI* engine) {
  engine->End();
  delete engine;
}

typedef cpp11::external_pointer<tesseract::TessBaseAPI, tess_finalizer> TessPtr;

inline void set_tesseract_options(tesseract::TessBaseAPI* engine,
                                  cpp11::list options) {
  for (int i = 0; i < options.size(); ++i) {
    std::string key = cpp11::as_cpp<std::string>(options.names()[i]);
    std::string value = cpp11::as_cpp<std::string>(options[i]);
    engine->SetVariable(key.c_str(), value.c_str());
  }
}

inline TessPtr make_tess_ptr(tesseract::TessBaseAPI* engine,
                             cpp11::list options = cpp11::list()) {
  set_tesseract_options(engine, options);
  return TessPtr(engine);
}
