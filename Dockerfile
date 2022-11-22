FROM python:latest

COPY main.py /

RUN python -m pip install rethinkdb

CMD ["python", "main.py"]
