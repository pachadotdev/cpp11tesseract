// Windows-specific symbol fixes
#include "win_symbol_fixes.h"

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
