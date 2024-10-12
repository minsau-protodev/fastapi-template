# when you install a package, you will have to run make build to update image
build:
	@docker compose build

# This will run project and set us up in a bash environment.
up:
	@docker compose up -d
	@docker compose run --service-ports --rm core || true
