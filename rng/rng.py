from flask import Flask, Response
from .config import DevelopmentConfig
import os
import socket
import time

app = Flask(__name__)

# Enable debugging if the DEBUG environment variable is set and starts with Y
# Demo BB
# app.debug = os.environ.get("DEBUG", "").lower().startswith('y')

app.config.from_object(DevelopmentConfig) 
APPLICATION_CONFIG = os.environ.get("APPLICATION_CONFIG", "").lower()
if APPLICATION_CONFIG:
	app.config.from_envvar('APPLICATION_CONFIG')

hostname = socket.gethostname()

urandom = os.open("/dev/urandom", os.O_RDONLY)

def get_random_bytes(how_many_bytes):
	return os.read(urandom, how_many_bytes)

@app.route("/")
def index():
    return "RNG running on {}\n".format(hostname)


@app.route("/<int:how_many_bytes>")
def rng(how_many_bytes):
    # Simulate a little bit of delay
    time.sleep(0.1)
    return Response(
        get_random_bytes(how_many_bytes),
        content_type="application/octet-stream")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)

