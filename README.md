# FastAPI Template

[![CI/CD](https://github.com/minsau/fastapi-template/actions/workflows/main.yml/badge.svg)](https://github.com/minsau/fastapi-template/actions/workflows/main.yml)

The purpose of this project is to be used as base boiler plate for future web application built with `Fast API`

## Development


**Requirements**

- Pyenv: Tool to allow live together multiple python installations at the same time, [install](https://github.com/pyenv/pyenv)
- Virtualenv: Bring us the possibility of create multiple isolated group of requirements to avoid clash between projects modules.
- Poetry: Package manager, it comes with some utilities out of the box that are pretty good for projects
- Docker: Platform to deploy containers straightaway

**Launch docker containers**

In order to work properly the project needs some satellital applications for this we are using docker (the standar way).

Firstly create `.env` file from the example `.env.dist` it should works without a modification but feel free if you need to do adjustments

```bash
cp .env.dist .env
```

Once we have the `.env` ready we should launch our docker containers

```bash
make up
```

Once inside container you should run init (just if is the first time) and then up
```bash
dev init
dev up
```
Now all the changes that you have in your host machine will be reflected on container code

**Extra: work with VS Code**

If as me you love Visual Studio code this project is configured to work with, just need one extension:

- [Remote Container](https://code.visualstudio.com/docs/remote/containers)

Once you have it installed just need to launch (with make up) the core project and then select the container in vs code
with this you can go to debug menu and click in green button to launch project.

When you are inside the container you could go to VS Code test section and you can appreciate that test discovery is active.

## Continuous Integration

**Requirements**

- GitHub account
- Docker Hub account (but you can adapt it for AWS or GCP)

**GitHub Actions**

This project uses GitHub Actions for CI/CD. The workflow is defined in `.github/workflows/main.yml`. Every time you push to a branch or create a pull request, it will run:

- For all branches and pull requests:
  - lint (using pre-commit)
  - test

- For the main branch:
  - lint
  - test
  - build Docker image
  - push Docker image to Docker Hub

**Locally**

To activate pre-commit in local environments just need to install `pre-commit`

```bash
pre-commit install
```
Those will take some time until ends, once has finished every time you create a commit first will validate if match with code requirements and will fail if not

**Build and Push image**
In order to show how the build process should work the project will build and push a code image to Docker hub, for this you need some env vars in circle ci:

- TAG: Image tag (ex. latest)
- IMAGE_OWNER: Your docker hub user
- DOCKERHUB_PASS: Docker hub pass for push image
- DOCKERHUB_USERNAME: Docker hub user for push image

## Monitoring
In order to use this project as a base for common projects it must have a way to monitor how the things are in prod environments for this it has a basic integration with [Sentry](https://docs.sentry.io/) (I love it) to track unhandled errors and verify all the path of it,  and new relic in order to track app performance.

this is an optional feature that I recommend to consider but if don't want it you can skip this configuration.

For New Relic we need next env vars:
- NEW_RELIC_CONFIG_FILE: This is almost a constant, usually will have `newrelic.ini` as value, but you can change it for something that fits you.
- NEW_RELIC_LICENSE_KEY: Seriously?
- NEW_RELIC_ENVIRONMENT: This var indicates in what environment is happening the things, and is used for custom configurations.

Additionally you can use Slack to receive some alerts from both services.

## Deployment

Important, this project should be considered as an initial template, depending on your business necessities you will need to update a lot of things, so, although I want to create 360 project the deployment section should be coped by you.
