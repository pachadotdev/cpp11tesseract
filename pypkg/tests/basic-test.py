import cpp11tesseract
engine = cpp11tesseract.TesseractEngine("eng")
text = engine.ocr_file("tests/receipt.jpg")
print(text)
