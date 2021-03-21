from Frame_Extraction import frame_extraction
from detect_blur import variance_of_laplacian, detect_blur
import time
""" from flask import Flask, render_template, request, jsonify
from flask_restful import Api, Resource
import pickle
import numpy as np
import requests

# model = pickle.load(open('iri.pkl', 'rb'))

app = Flask(__name__)
api = Api(app)


class getVideo(Resource):
    def post(self, fileName, uploadFileUrl):
        return {"name": fileName, "fileurl": uploadFileUrl}


api.add_resource(getVideo, "/getVideo/<string:fileName>/<string:uploadFileUrl>")


if __name__ == "__main__":
    app.run(debug=True) """

frame_extraction()
time.sleep(5)
detect_blur() 
