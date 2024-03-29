FROM python:3.10.2-alpine

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONNUBUFFERED=1
ENV DEBUG 0

RUN apk update \
    && apk add --virtual build-essential gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN adduser -D myuser
USER myuser

CMD gunicorn jwidegts.wsgi:application --bind 0.0.0.0:$PORT