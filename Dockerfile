FROM python:3.8-alpine
WORKDIR /app
COPY app/* /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 3000
CMD ["python", "app.py"]
