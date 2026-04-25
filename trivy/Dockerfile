FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    python3 \
    python3-pip \
    openssh-server

ADD https://example.com/installer/demoapp-bundle.tar.gz /tmp/bundle.tar.gz

RUN tar -xzf /tmp/bundle.tar.gz -C /opt

COPY . /app

WORKDIR /app

RUN pip3 install -r requirements.txt

EXPOSE 22 80 443

CMD ["python3", "/app/server.py"]
