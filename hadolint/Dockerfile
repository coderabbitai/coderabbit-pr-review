FROM ubuntu
MAINTAINER someone@example.com
RUN apt-get update && apt-get install -y python3 pip
COPY . /app
WORKDIR /app
RUN chmod 777 /app
CMD ["python3", "app.py"]

