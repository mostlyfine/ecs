import logging
import sys
from flask import Flask

app = Flask(__name__)

# Flaskのログを標準出力にリダイレクト
handler = logging.StreamHandler(sys.stdout)
handler.setLevel(logging.INFO)
app.logger.addHandler(handler)


@app.route("/")
def index():
    message = "Hello wolrd."
    app.logger.info(message)
    return f"<p>{message}</p>"


@app.route("/error")
def error():
    message = "This is Error message."
    app.logger.error(message)
    return f"<p>{message}</p>"


@app.route("/warn")
def warn():
    message = "This is Warning message."
    app.logger.warning(message)
    return f"<p>{message}</p>"


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=3000, debug=True)
