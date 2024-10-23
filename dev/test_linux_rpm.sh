sudo docker build -t fedora_ssh .
sudo docker run -d -p 2222:22 fedora_ssh
ssh dockeruser@localhost -p 2222

sudo dnf install -y R tesseract-devel leptonica-devel libcurl-devel poppler-cpp-devel
sudo Rscript -e 'install.packages("remotes", repos="https://cloud.r-project.org")'
sudo Rscript -e 'remotes::install_github("pachadotdev/cpp11tesseract"); cat(cpp11tesseract::ocr(system.file("examples", "testocr.png", package = "cpp11tesseract")))'