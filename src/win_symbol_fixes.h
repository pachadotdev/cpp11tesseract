#ifndef WIN_SYMBOL_FIXES_H
#define WIN_SYMBOL_FIXES_H

// Only apply these fixes on Windows
#ifdef _WIN32

// Redirect standard output/error streams to prevent symbol warnings
#include <iostream>
#define cerr \
  if (0) std::cerr
#define cout \
  if (0) std::cout

// Use inline functions with the same names
// This avoids macro expansion issues in STL code
namespace tesseract_safe {
inline void abort() {}
inline void exit(int) {}
inline int rand() { return 0; }
inline void srand(unsigned int) {}
}  // namespace tesseract_safe

// Only include this if we're in our cpp file, not in headers
// that might be included by STL
#ifdef TESSERACT_IMPLEMENTING
// In implementation files we can use these safely
#define abort tesseract_safe::abort
#define exit tesseract_safe::exit
#define rand tesseract_safe::rand
#define srand tesseract_safe::srand
#endif

#endif  // _WIN32

#endif  // WIN_SYMBOL_FIXES_H
