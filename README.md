# django-nginx-postgres-docker
A Docker Compose starter kit with Nginx, Django, Gunicorn, and Postgres database. You can use this as a template to build out your own Django application for development or production. The Postgres data is saved locally in the `postgres` directory, and any changes saved to the database while the app is running will persist.  Static and media files are configured to be served by Nginx, and stored locally in the `static_volume` and `media_volume` directories.

## Nginx configuration
The default Nginx configuration file can be found at`nginx/djangoapp.conf`.  It's set to run the site for local development at http://localhost:8000

## Postgres configuration
Default Postgres setting can be found in `config/db/database1_env`. We use `database1` everywhere for default values, but you can change these values to whatever suits you:

POSTGRES_USER=database1_role  
POSTGRES_PASSWORD=database1_password  
POSTGRES_DB=database1

You must also update the DATABASES code block in the `settings.py` file in the Django application

    DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'database1',
        'USER': 'database1_role',
        'PASSWORD': 'database1_password',
        'HOST': 'database1',  # <-- IMPORTANT: same name as docker-compose service!
        'PORT': '5432',
        }
    }

And match the container name in the `docker-compose.yml` file for the Postres container.

    database1:  # <-- IMPORTANT: same name as in Djano settings.py, otherwise Django won't find the database!
    image: postgres:11
    container_name: database1
    env_file:  # <-- match values to Djano settings.py
      - config/db/database1_env
    networks:
      - database1_network  
    volumes:
      - ./postgres/data:/var/lib/postgresql/data # <-- bind the database to local directory

## Install Instructions
Prerequisite: You need to have Docker installed on the system where you'll be running this app. [Get Docker](https://docs.docker.com/install/)

1. Using your command line interface, `cd` to the cloned directory containing the docker-compose.yml file.
2. Run `docker-compose build` to download and build the required Docker images.
3. Run `docker-compose up -d` to launch the Django application.
4. The first time the application is run, you need to execute the usual Django management commands to perform database migrations, create a super user, and collect static files:
    1. SSH to the Django container by running `docker exec -it djangoapp bash`. Now you're inside the Django container.
    2. Run `cd starterkit`
    3. Run `./manage.py migrate`
    4. Run `./manage.py createsuper user`
    5. Run `./manage.py collectstatic`
    6. Run `exit` to leave the container      


