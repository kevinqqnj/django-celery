# django-celery demo

> django 2.0, celery 4, redis 3

`docker-compose up --build`

```
docker-compose run web bash
# cd /code/proj
# python manage.py migrate
# python manage.py shell
>> from myapp.tasks import *
>> add.delay(10, 20)
<AsyncResult: 46adf687-a9b2-407e-baf1-xxx>
```
