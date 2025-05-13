from flask import Blueprint, redirect, render_template, request, send_file, session, url_for
import qrcode
import tempfile

# -------------------------

index_bp = Blueprint('index', __name__)

# -------------------------

@index_bp.route('/')
def page():

    """
    Render the page
    """
    if 'url' not in session:
        session['url'] = 'https://github.com/robertovicario/SquareCode'
    
    if 'img' not in session:
        session['img'] = url_for('static', filename='img/home/qrcode.png')
    else:
        session['img'] = url_for('index.get_qrcode')

    # -------------------------

    return render_template('pages/home.html')

@index_bp.route('/qrcode/create', methods=['POST'])
def create_qrcode():

    """
    Create the image in local
    """
    url = request.form.get('url')
    qr = qrcode.QRCode(
        version=2,
        error_correction=qrcode.constants.ERROR_CORRECT_L,
        box_size=20,
        border=4,
    )
    qr.add_data(url)
    qr.make(fit=True)
    file_path = f"{tempfile.gettempdir()}/qrcode.png"
    img = qr.make_image(fill_color='black', back_color='white')
    img.save(file_path)

    # -------------------------

    session['url'] = url
    session['img'] = file_path

    # -------------------------

    return redirect(url_for('index.page'))

@index_bp.route('/qrcode/get', methods=['GET'])
def get_qrcode():
    file_path = f"{tempfile.gettempdir()}/qrcode.png"
    return send_file(file_path, mimetype='image/png')
