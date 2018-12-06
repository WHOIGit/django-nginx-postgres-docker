# django-nginx-postgres-docker
A Docker Compose starter kit with Nginx, Django, Gunicorn, and Postgres database.

## Install Instructions
Prerequisite: You need to have Docker installed on the system where you'll be running this app. [Get Docker](https://docs.docker.com/install/)

1. Using your command line interface, 'cd' to the cloned directory containing the docker-compose.yml file.
2. Run 'docker-compose build' to download and build the required Docker images.
3. Run 'docker-compose up -d' to launch the Django application.
4. The first time the application is run, you need to execute the usual Django management commands to perform database migrations, create a super user, and collect static files:
    1. Connect to the Django container by running 'docker exec -it djangoapp bash'
    2. Run 'cd starterkit'
    3. Run './manage.py migrate'
    4. Run './manage.py createsuper user'
    5. Run './manage.py collectstatic'

