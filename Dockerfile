# start from an official Python image
FROM python:3.6
ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client

# arbitrary location choice: you can change the directory
RUN mkdir -p /var/djangoapp
WORKDIR /var/djangoapp


# install our two dependencies
COPY djangoapp/requirements.txt /var/djangoapp
RUN pip install -r requirements.txt

# copy our project code
COPY djangoapp/starterkit /var/djangoapp/starterkit
# run Django management commands at start
RUN cd starterkit && python manage.py collectstatic --no-input

# expose the port 8000
EXPOSE 8000

# define the default command to run when starting the container
CMD ["gunicorn", "--chdir", "starterkit", "--bind", ":8000", "starterkit.wsgi:application", "--reload"]