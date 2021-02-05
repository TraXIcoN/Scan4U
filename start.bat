set img_folder="data"
set arg="--image"

start M:\TEPROJECT\CamScannerClone\Scan4U\Frame_Extraction.py
TIMEOUT 5
start M:\TEPROJECT\CamScannerClone\Scan4U\detect_blur.py --image data
start M:\TEPROJECT\CamScannerClone\Scan4U\Duplicate_detection1.py