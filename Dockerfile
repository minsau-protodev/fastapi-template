FROM python:3.12.0-slim-bullseye

RUN groupadd -g 1337 app && \
    useradd -m -d /opt/app -u 1337 -g app app

ENV PYTHONPATH=${PYTHONPATH}:${PWD}

# TODO: Improve this to install dev dependencies just in development
RUN pip3 install poetry
WORKDIR /temp
ADD pyproject.toml /temp/pyproject.toml
RUN poetry config virtualenvs.create false

RUN poetry install
#ARG INSTALL_DEV=false
#RUN bash -c "if [ $INSTALL_DEV == 'true' ] ; then poetry install --no-root ; else poetry install --no-root --no-dev ; fi"

USER app
WORKDIR /opt/app
ENV PATH /opt/app/.local/bin:$PATH

EXPOSE 8000

ADD --chown=app:app ./docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ADD --chown=app:app scripts/dev /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/dev"]

ENTRYPOINT ["/docker-entrypoint.sh"]
