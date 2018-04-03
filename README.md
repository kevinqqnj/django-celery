# django-celery demo

> django 2.0, celery 4, redis 3

> integrating Celery 4 into django 2.0, run workers and beat


## Setup
1. clone this repo.

2. open first terminal, compose by docker. using python:3 image
`docker-compose up --build`

You should see services are ready:
```
celeryworker_1  |  -------------- celery@086fff8f2388 v4.1.0 (latentcall)
celeryworker_1  | ---- **** -----
celeryworker_1  | --- * ***  * -- Linux-4.9.89-boot2docker-x86_64-with-debian-8.10 2018-04-03 0
celeryworker_1  | -- * - **** ---
celeryworker_1  | - ** ---------- [config]
celeryworker_1  | - ** ---------- .> app:         proj:0x7f3020c172b0
celeryworker_1  | - ** ---------- .> transport:   redis://redis:6379//
celeryworker_1  | - ** ---------- .> results:     redis://redis/
celeryworker_1  | - *** --- * --- .> concurrency: 1 (prefork)
celeryworker_1  | -- ******* ---- .> task events: OFF (enable -E to monitor tasks in this worke
celeryworker_1  | --- ***** -----
celeryworker_1  |  -------------- [queues]
celeryworker_1  |                 .> celery           exchange=celery(direct) key=celery
celeryworker_1  |
celeryworker_1  |
celeryworker_1  | [tasks]
celeryworker_1  |   . myapp.tasks.add
celeryworker_1  |   . myapp.tasks.mul
celeryworker_1  |   . myapp.tasks.xsum
celeryworker_1  |   . proj.celery.debug_task
celeryworker_1  |
celeryworker_1  | [2018-04-03 02:37:07,230: INFO/MainProcess] Connected to redis://redis:6379//
```

## Run task
1. open another terminal
`docker-compose run --rm web bash`

2. run command in bash
```
# cd /code
# python manage.py migrate
# python manage.py shell
>> from myapp.tasks import *
>> add.delay(10, 20)
<AsyncResult: 46adf687-a9b2-407e-baf1-xxx>
```

Now you should see celery is working in first terminal:
```
celeryworker_1  | [2018-04-03 02:37:22,954: INFO/MainProcess] Received task: myapp.tasks.add[84562885-0e3e725deeab]
celeryworker_1  | [2018-04-03 02:37:22,968: INFO/ForkPoolWorker-1] Task myapp.tasks.add[84562885-0e3e725deeab] succeeded in 0.007631423002749216s: 3
```
