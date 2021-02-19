set img_folder="data"
set arg="--image"

python Frame_Extraction.py
python detect_blur.py %arg% %img_folder%
python Duplicate_detection1.py