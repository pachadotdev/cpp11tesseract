#include <leptonica/allheaders.h>
#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include <tesseract/baseapi.h>

#include <memory>

namespace py = pybind11;

class TesseractEngine {
 public:
  TesseractEngine(const std::string &lang = "eng") {
    // engine = std::make_unique<tesseract::TessBaseAPI>();
    engine.reset(new tesseract::TessBaseAPI());
    if (engine->Init(NULL, lang.c_str())) {
      throw std::runtime_error("Could not initialize Tesseract.");
    }
  }

  ~TesseractEngine() { engine->End(); }

  std::string ocr_file(const std::string &file) {
    Pix *image = pixRead(file.c_str());
    if (!image) {
      throw std::runtime_error("Failed to read image.");
    }

    engine->SetImage(image);
    char *text = engine->GetUTF8Text();
    std::string result(text);
    delete[] text;
    pixDestroy(&image);

    return result;
  }

 private:
  std::unique_ptr<tesseract::TessBaseAPI> engine;
};

PYBIND11_MODULE(_cpp11tesseract, m) {
  if (!py::hasattr(m, "TesseractEngine")) {
    py::class_<TesseractEngine>(m, "TesseractEngine")
        .def(py::init<const std::string &>())
        .def("ocr_file", &TesseractEngine::ocr_file);
  }
}
