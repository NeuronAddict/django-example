FROM registry.access.redhat.com/ubi9/python-39:1-90

USER 0
ADD . .

# Install the dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    python manage.py collectstatic --noinput && \
    python manage.py migrate

USER 1001

# Run the application
CMD python -m gunicorn django_example.wsgi:application --bind 0.0.0.0:8000 --workers 5
