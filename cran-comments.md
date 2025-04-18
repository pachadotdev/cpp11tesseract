## R CMD check results

0 errors | 0 warnings | 1 note

* C++11 specification is essential as the tesseract library demands it.
* checking compiled code ... WARNING
  File 'cpp11tesseract/libs/x64/cpp11tesseract.dll':
    Found symbols like 'std::cerr', 'abort', 'exit', 'rand', etc.

  This only affects R 4.5.0 on Windows. These symbols appear in the DLL because
  they are part of the underlying Tesseract and Leptonica static libraries. Our
  package code does not call these functions, but they are unavoidably included
  when statically linking against these third-party OCR libraries.
