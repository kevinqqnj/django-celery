FROM python:3

ENV PYTHONUNBUFFERED 1

RUN mkdir /code
RUN cd /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

COPY ./start.sh /code/start.sh
RUN chmod 777 /code/start.sh

WORKDIR /code
