FROM registry.fedoraproject.org/f33/python3

# Add application sources with correct permissions for OpenShift
USER 0
ADD . .
RUN chown -R 1001:0 ./
USER 1001

# Install the dependencies
RUN pip install -r requirements.txt && \
    python manage.py collectstatic --noinput && \
    python manage.py migrate

# Run the application
CMD python -m gunicorn django_example.wsgi:application --bind 0.0.0.0:8000 --workers 5
