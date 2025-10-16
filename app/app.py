# -------------------------
# Dependencies
# -------------------------

from flask import Flask
import os
import json

# -------------------------

from routes.fallback import fallback_bp
from routes.index import index_bp

# -------------------------
# Flask Settings
# -------------------------

app = Flask(__name__)

# -------------------------
# Configuration Settings
# -------------------------

config_path = os.path.join(os.path.dirname(__file__), 'config', 'settings.json')
with open(config_path, 'r') as f:
    config = json.load(f)

@app.context_processor
def config_json():
    return dict(config=config)

# -------------------------
# Blueprints Registration
# -------------------------

app.register_blueprint(fallback_bp)
app.register_blueprint(index_bp)

# -------------------------
# Starting Point
# -------------------------

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7860)
