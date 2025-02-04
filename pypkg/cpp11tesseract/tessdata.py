import os
import requests

def tesseract_download(lang, model="best", datapath=None):
    if not isinstance(lang, str):
        raise ValueError("Language must be a string")

    repo = "tessdata_best" if model == "best" else "tessdata_fast"
    url = f"https://github.com/tesseract-ocr/{repo}/raw/main/{lang}.traineddata"

    if datapath is None:
        datapath = os.getenv("TESSDATA_PREFIX", "/usr/share/tesseract-ocr/4.00/tessdata")

    destfile = os.path.join(datapath, f"{lang}.traineddata")

    response = requests.get(url, stream=True)
    if response.status_code == 200:
        with open(destfile, 'wb') as f:
            for chunk in response.iter_content(1024):
                f.write(chunk)
        print(f"Downloaded {lang}.traineddata")
    else:
        raise Exception(f"Download failed: HTTP {response.status_code}")
