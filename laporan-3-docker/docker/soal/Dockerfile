FROM ubuntu:16.04

RUN apt-get update -y
RUN apt-get install -y python python-pip python-dev build-essential libmysqlclient-dev
RUN pip install --upgrade pip
COPY ./reservasi /app
WORKDIR /app
RUN pip install -r req.txt
ENTRYPOINT ["python"]
CMD ["server.py"]