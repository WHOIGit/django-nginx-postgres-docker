# django-nginx-postgres-docker
A Docker Compose starter kit with Nginx, Django, Gunicorn, and Postgres database.

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
    6. Run `exit' to leave the container`

## Nginx configuration
The default Nginx configuration file can be found at the `nginx/djangoapp.conf`.  It's set to run the site for local development at http://localhost:8000

## Postgres configuration
Default Postgres setting can be found in `config/db/database1_env`. We use `database1` everywhere for default values, but you can change these values to whatever suits you:

POSTGRES_USER=database1_role
POSTGRES_PASSWORD=database1_password
POSTGRES_DB=database1

You must also update the DATABASES code block in the `settings.py` file in the Django application, and match the name in the `docker-compose.yml` file for the Postres container.


