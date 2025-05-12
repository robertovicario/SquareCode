from flask import Flask
from flask_frozen import Freezer
import secrets
import sys

from routes.index import index_bp

# -------------------------

app = Flask(__name__)
app.secret_key = secrets.token_hex(32)
app.register_blueprint(index_bp)
app.config['FREEZER_RELATIVE_URLS'] = True

freezer = Freezer(app)

# -------------------------

if __name__ == '__main__':
    if len(sys.argv) > 1 and sys.argv[1] == 'build':
        freezer.freeze()
    else:
        app.run(debug=True, host='0.0.0.0', port=8999)
