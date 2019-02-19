FROM ubuntu:18.04

# сборка контейнера: docker build -t ds_docker:latest .
# запуск
# сборка pipenv:    docker run --volume $(pwd)/app:/www/app -it --rm ds_docker:latest pipenv
# подключение в sh: docker run --volume $(pwd)/app:/www/app -it --rm ds_docker:latest bash
# запуск JUpyter:   docker run --volume $(pwd)/app:/www/app -p 8889:8888 -it --rm ds_docker:latest jupyter

RUN apt-get update && apt-get install -y curl python3-pip libatlas-base-dev libhdf5-dev python3.6 python3.6-dev \
    libpcre3-dev mercurial

RUN update-alternatives --install /usr/bin/python3 python3.6 /usr/bin/python3.6 0 && pip3 install pipenv

ENV PYTHONPATH=/www/app
ENV PIPENV_VENV_IN_PROJECT=1
ENV PIPENV_CACHE_DIR=/www/app/.cache/pipenv
ENV PIP_CACHE_DIR=/www/app/.cache/pip
ENV PIP_NO_BINARY=numpy
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /www/app

ENTRYPOINT ["docker-entrypoint.sh"]
