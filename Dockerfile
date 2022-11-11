FROM alpine:latest
RUN apk update

COPY main.py /

CMD python3 main.py
