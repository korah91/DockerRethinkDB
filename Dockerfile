FROM ubuntu:latest

RUN apt update 
# stdout a /dev/null porque -qq no funciona ya que apt llama a dpkg y printea
RUN apt install python3 -y > /dev/null
RUN apt install python3-pip -y > /dev/null
COPY main.py /

RUN python3 -m pip install rethinkdb

CMD ["python3", "main.py"]
