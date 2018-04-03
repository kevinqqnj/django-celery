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
<AsyncResult: 46adf687-a9b2-407e-baf1>
>> from proj.celery import debug_task
>>> debug_task.delay()
<AsyncResult: 7b80ed53-843b-4350-bddc>
```

Now you should see celery is working in first terminal:
```
celerybeat_1    | celery beat v4.1.0 (latentcall) is starting.
celerybeat_1    | __    -    ... __   -        _
celerybeat_1    | LocalTime -> 2018-04-03 03:22:27
celerybeat_1    | Configuration ->
celerybeat_1    |     . broker -> redis://redis:6379//
celerybeat_1    |     . loader -> celery.loaders.app.AppLoader
celerybeat_1    |     . scheduler -> celery.beat.PersistentScheduler
celerybeat_1    |     . db -> celerybeat-schedule
celerybeat_1    |     . logfile -> [stderr]@%INFO
celerybeat_1    |     . maxinterval -> 5.00 minutes (300s)
celeryworker_1  | [2018-04-03 02:37:22,954: INFO/MainProcess] Received task: myapp.tasks.add[84562885-0e3e725deeab]
celeryworker_1  | [2018-04-03 02:37:22,968: INFO/ForkPoolWorker-1] Task myapp.tasks.add[84562885-0e3e725deeab] succeeded in 0.007631423002749216s: 3
celeryworker_1  | [2018-04-03 03:15:51,207: INFO/MainProcess] Received task: proj.celery.debug_task[7b80ed53-843b-4350-b
ddc]
celeryworker_1  | [2018-04-03 03:15:51,210: WARNING/ForkPoolWorker-1] Request: <Context: {'lang': 'py', 'task': 'proj.ce
lery.debug_task', 'id': '7b80ed53-843b-4350-bddc', 'eta': None, 'expires': None, 'group': None, 'retries':
0, 'timelimit': [None, None], 'root_id': '7b80ed53-843b-4350-bddc', 'parent_id': None, 'argsrepr': '()', 'k
wargsrepr': '{}', 'origin': 'gen12@fda78a089793', 'reply_to': '872bb33f-9556-33d7-bd86', 'correlation_id':
'7b80ed53-843b-4350-bddc', 'delivery_info': {'exchange': '', 'routing_key': 'celery', 'priority': 0, 'redel
ivered': None}, 'args': [], 'kwargs': {}, 'hostname': 'celery@086fff8f2388', 'is_eager': False, 'callbacks': None, 'errb
acks': None, 'chain': None, 'chord': None, 'called_directly': False, '_protected': 1}>
```
