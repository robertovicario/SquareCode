/////////////////////////
/**
 * Home :: Pages
 */
/////////////////////////

document.addEventListener('DOMContentLoaded', () => {
    const input_url = document.getElementById('input-url');
    const qrcode = document.getElementById('qrcode');
    const btn_download = document.getElementById('btn-download');
    let timeout_id;

    input_url.addEventListener('input', () => {
        clearTimeout(timeout_id);
        timeout_id = setTimeout(() => {
            const url = new FormData();
            url.append('url', input_url.value);

            fetch("/qrcode/create", {
                method: 'POST',
                body: url
            })
            .then(() => {
                const ts = new Date().getTime();
                qrcode.src = `/qrcode/get?ts=${ts}`;
                btn_download.href = `/qrcode/get?ts=${ts}`;
            })
            .catch((error) => {
                console.error(error);
                alert(error);
            });
        }, 100);
    });
});

/////////////////////////
