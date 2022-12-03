FROM alpine:latest

RUN apk update 
# stdout a /dev/null porque -qq no funciona ya que apt llama a dpkg y printea
RUN apk add python3 > /dev/null
RUN apk add py3-pip > /dev/null
COPY main.py /

RUN python3 -m pip install rethinkdb

CMD ["python3", "main.py"]
