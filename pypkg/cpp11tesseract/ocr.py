import _cpp11tesseract

def ocr(file: str, engine=None, HOCR=False, opw="", upw=""):
    if isinstance(engine, str):
        engine = _cpp11tesseract.TesseractEngine(engine)
    
    if not isinstance(engine, _cpp11tesseract.TesseractEngine):
        raise ValueError("Invalid engine instance")

    if isinstance(file, str):
        return engine.ocr_file(file, HOCR)
    elif isinstance(file, bytes):
        return engine.ocr_raw(file, HOCR)
    else:
        raise ValueError("Argument 'file' must be a file path or raw bytes")

def ocr_data(file: str, engine=None):
    """Extracts text with bounding boxes and confidence scores."""
    if isinstance(engine, str):
        engine = _cpp11tesseract.TesseractEngine(engine)
    
    if not isinstance(engine, _cpp11tesseract.TesseractEngine):
        raise ValueError("Invalid engine instance")

    if isinstance(file, str):
        return engine.ocr_file_data(file)
    else:
        raise ValueError("Argument 'file' must be a file path")
