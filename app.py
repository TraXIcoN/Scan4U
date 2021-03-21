import pyrebase

config = {
    "apiKey": "AIzaSyBfqCyenpL_Kjbj7dHhWxhQxtAHQ17GMBM"
}

firebase = pyrebase.initialise_app(config)

storage = firebase.storage()