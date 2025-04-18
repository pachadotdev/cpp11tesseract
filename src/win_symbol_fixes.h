#ifndef WIN_SYMBOL_FIXES_H
#define WIN_SYMBOL_FIXES_H

// Only apply these fixes on Windows
#ifdef _WIN32

// Redirect standard output/error streams to prevent symbol warnings
#include <iostream>
#define cerr if(0) std::cerr
#define cout if(0) std::cout

// Intercept problematic C functions by including related headers
// and redefining the symbols
#include <cstdlib>

// If you're sure these functions are never called in your code,
// you can redirect them to empty implementations
#ifndef abort
#define abort() ((void)0)
#endif

#ifndef exit
#define exit(x) ((void)0)
#endif

#ifndef rand
#define rand() 0
#endif

#ifndef srand
#define srand(x) ((void)0)
#endif

#endif // _WIN32

#endif // WIN_SYMBOL_FIXES_H
