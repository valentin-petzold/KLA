FROM python:3.9-slim

WORKDIR /app
COPY fibonacci.py /app/

CMD ["python", "fibonacci.py"]
