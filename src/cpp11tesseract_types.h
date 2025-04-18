// bypass C++ functions that are not CRAN-compliant
#ifndef SYMBOL_INTERCEPTORS_H
#define SYMBOL_INTERCEPTORS_H

// Only apply these redirections when building for Windows
#if defined(_WIN32)

#include <cstdlib>
#include <iostream>

#define cerr \
  if (0) std::cerr
#define cout \
  if (0) std::cout

inline void R_friendly_abort() {
  Rprintf("Internal error detected (abort intercepted)\n");
}
inline void R_friendly_exit(int status) {
  Rprintf("Exit requested with status %d (intercepted)\n", status);
}

#define abort R_friendly_abort
#define exit(x) R_friendly_exit(x)

inline int R_friendly_rand() { return 0; }
inline void R_friendly_srand(unsigned int seed) {}
#define rand R_friendly_rand
#define srand(x) R_friendly_srand(x)

#endif
#endif

// Try multiple include paths for better cross-platform compatibility
#if __APPLE__
// On macOS, try multiple include paths
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
