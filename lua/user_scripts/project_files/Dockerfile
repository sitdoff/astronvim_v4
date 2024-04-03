FROM python:3.11-slim-bookworm
LABEL creator="Roman Ivanov"
LABEL email="sitdoff@gmail.com"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt
COPY ./<project_name> /code/
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
