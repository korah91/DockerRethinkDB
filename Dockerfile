FROM ubuntu:latest

RUN apt update
RUN apt install python3 -y

COPY main.py /

RUN python -m pip install rethinkdb

CMD ["python3", "main.py"]
