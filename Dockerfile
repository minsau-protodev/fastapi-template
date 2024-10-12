FROM python:3.12.0-slim-bullseye

RUN groupadd -g 1337 app && \
    useradd -m -d /opt/app -u 1337 -g app app

ENV PYTHONPATH=${PYTHONPATH}:${PWD}

# Install poetry
RUN pip install --upgrade pip && \
    pip install poetry==1.7.1

WORKDIR /temp
COPY pyproject.toml poetry.lock* /temp/

RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi

USER app
WORKDIR /opt/app
ENV PATH /opt/app/.local/bin:$PATH

EXPOSE 8000

COPY --chown=app:app ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

COPY --chown=app:app scripts/dev /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/dev"]

ENTRYPOINT ["/docker-entrypoint.sh"]
