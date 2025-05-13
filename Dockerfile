# Usa un'immagine base di Python 3.9
FROM python:3.9

# Imposta la directory di lavoro all'interno del contenitore
WORKDIR /app

# Copia il file requirements.txt dalla directory ./app nel contenitore
COPY app/requirements.txt /app/requirements.txt

# Copia tutto il codice sorgente nella directory di lavoro
COPY . /app

# Installa le dipendenze elencate nel requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Esponi la porta 7860 per il traffico in entrata
EXPOSE 7860

# Avvia il server usando gunicorn (che è una scelta migliore per la produzione)
CMD ["gunicorn", "--bind", "0.0.0.0:7860", "app.app:app"]
