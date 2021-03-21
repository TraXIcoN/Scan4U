# USAGE
# python detect_blur.py --images images

# import the necessary packages
from imutils import paths
import argparse
from cv2 import cv2
import os
import shutil
import numpy


def variance_of_laplacian(image):
    # compute the Laplacian of the image and then return the focus
    # measure, which is simply the variance of the Laplacian
    return cv2.Laplacian(image, cv2.CV_64F).var()


def detect_blur():
    try:
        if not os.path.exists('blur_clear'):
            os.makedirs('blur_clear')
    except OSError:
        print('Error: Creating directory of data')

    # construct the argument parse and parse the arguments
    ap = argparse.ArgumentParser()
    ap.add_argument("-t", "--threshold", type=float, default=1000.0,
                    help="focus measures that fall below this value will be considered 'blurry'")
    args = vars(ap.parse_args())
    args['images'] = 'data'

    currentFrame = 0
    fmmm = []
    summ = 0
    # loop over the input images
    for imagePath in paths.list_images(args["images"]):
        # load the image, convert it to grayscale, and compute the
        # focus measure of the image using the Variance of Laplacian
        # method
        image = cv2.imread(imagePath)
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        fm = variance_of_laplacian(gray)
        text = "Not Blurry"

        # if the focus measure is less than the supplied threshold,
        # then the image should be considered "blurry"
        fmmm.append((fm,imagePath))
        summ += fm

        # show the image
        # cv2.putText(image, "{}: {:.2f}".format(text, fm), (10, 30),
        #	cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 3)
        #cv2.imshow("Image", image)

        key = cv2.waitKey(0)
    args["threshold"] = numpy.median(fmmm)
    for i in fmmm:
        if i[0] > args["threshold"]:
            shutil.move(i[1], './blur_clear/')
