#ifndef CPP11TESSERACT_TYPES_H
#define CPP11TESSERACT_TYPES_H

#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>
#include <memory>
#include <vector>
#include <string>

inline void tess_finalizer(tesseract::TessBaseAPI* engine) {
    engine->End();
    delete engine;
}

#endif // CPP11TESSERACT_TYPES_H
