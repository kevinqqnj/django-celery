# !/bin/bash
python /code/proj/manage.py migrate
python /code/proj/manage.py runserver 0.0.0.0:5000
