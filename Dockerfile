# FROM python:3.9
# WORKDIR /app
# COPY . /app
# RUN pip install -r requirements.txt
# RUN python manage.py collectstatic --noinput

FROM python:3.9.10-slim-bullseye as base-system

RUN useradd djcms

COPY --chown=djcms:djcms . /app

RUN set -eux; \
    apt-get update --yes --quiet && apt-get install --yes --quiet --no-install-recommends --no-install-suggests \
      build-essential libmariadb-dev; \
    pip install -r /app/requirements.txt; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false build-essential; \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000

WORKDIR /app
USER djcms
