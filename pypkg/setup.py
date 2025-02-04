import os
import shutil
from setuptools import setup, Extension
import pybind11

ext_modules = [
    Extension(
        "cpp11tesseract._cpp11tesseract",
        sources=["cpp11tesseract.cpp"],
        include_dirs=[pybind11.get_include(), "/usr/include"],
        library_dirs=["/usr/lib"],
        libraries=["tesseract"],
        extra_compile_args=["-std=c++11", "-O3"],
        language="c++"
    ),
]

setup(
    name="cpp11tesseract",
    version="0.1",
    packages=["cpp11tesseract"],
    ext_modules=ext_modules,
    zip_safe=False,
)

# Rename the compiled shared object file if necessary
def rename_shared_object():
    build_lib = "cpp11tesseract"
    for f in os.listdir(build_lib):
        if f.startswith("_cpp11tesseract") and f.endswith(".so") and f != "_cpp11tesseract.so":
            old_name = os.path.join(build_lib, f)
            new_name = os.path.join(build_lib, "_cpp11tesseract.so")
            shutil.move(old_name, new_name)
            print(f"Renamed {old_name} → {new_name}")

rename_shared_object()
