import hashlib

class TesseractManager:
    _store = {}

    @staticmethod
    def get_engine(language="eng", datapath=None, configs=None, options=None, cache=True):
        key = hashlib.md5(str((language, datapath, configs, options)).encode()).hexdigest()
        
        if cache and key in TesseractManager._store:
            return TesseractManager._store[key]
        
        engine = _cpp11tesseract.TesseractEngine(language)
        if cache:
            TesseractManager._store[key] = engine
        return engine
