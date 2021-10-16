FROM python:3.9.7-alpine

WORKDIR /app

COPY requirements.txt requirements.txt

RUN apk add --no-cache --upgrade --virtual .build-deps \
    gcc \
    linux-headers \
    musl-dev \
    && pip3.9 install -r requirements.txt

COPY ./ /app/