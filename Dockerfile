FROM python:alpine3.13

ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=adminpassword
ENV DJANGO_SUPERUSER_EMAIL=admin@example.com

COPY hawklingAPI /app
COPY requirements.txt /app/

WORKDIR /app

RUN pip install -r ./requirements.txt
RUN echo DJANGO_KEY=$(python -c "import secrets; print(secrets.token_urlsafe())") > hawklingAPI/hawklingAPI/.env
RUN python hawklingAPI/manage.py migrate
RUN python hawklingAPI/manage.py createsuperuser --no-input

CMD ["python", "hawklingAPI/manage.py", "runserver", "0.0.0.0:8000"]
