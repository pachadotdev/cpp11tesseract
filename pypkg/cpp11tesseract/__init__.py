import os
import sys
import glob

def _initialize_tessdata():
    tessdata_prefix = os.getenv("TESSDATA_PREFIX", "/usr/share/tesseract-ocr/4.00/tessdata")
    if not os.path.exists(tessdata_prefix):
        os.makedirs(tessdata_prefix, exist_ok=True)
    os.environ["TESSDATA_PREFIX"] = tessdata_prefix

_initialize_tessdata()

if "_cpp11tesseract" not in sys.modules:
    package_dir = os.path.dirname(__file__)
    shared_object_files = glob.glob(os.path.join(package_dir, "_cpp11tesseract*.so"))

    if shared_object_files:
        _shared_lib = shared_object_files[0]
        sys.path.insert(0, package_dir)
        _cpp11tesseract = __import__(os.path.basename(_shared_lib).split(".")[0])
    else:
        raise ImportError("Could not find _cpp11tesseract shared library!")

    from ._cpp11tesseract import TesseractEngine
else:
    _cpp11tesseract = sys.modules["_cpp11tesseract"]

from .ocr import ocr
from .tesseract import TesseractManager
from .tessdata import tesseract_download

__all__ = [
    "TesseractEngine",
    "ocr",
    "TesseractManager",
    "tesseract_download"
]
