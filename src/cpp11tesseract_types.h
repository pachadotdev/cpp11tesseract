#include <cpp11.hpp>

// Define R_NO_REMAP to prevent conflicts with cpp11
#define R_NO_REMAP
#define STRICT_R_HEADERS

// include R headers if needed
#ifdef _WIN32
#include <R.h>
#include <Rinternals.h>
#endif

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

#include <list>
#include <memory>
#include <string>
#include <vector>

#include "tesseract_config.h"

// Simple redirection for std::cerr and std::cout on Windows
// This is much less intrusive but still helps with the CRAN check
#ifdef _WIN32
#define cerr \
  if (0) std::cerr
#define cout \
  if (0) std::cout
#endif

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
