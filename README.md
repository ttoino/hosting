# Hosting

This repository is the public config for my personal website hosting.

## How it works

Every part of the system is a docker container. The containers are managed by docker-compose.

Routing, proxying and SSL handling is done by Nginx.

Docker images are built and pushed to a local registry.

When a new commit is pushed to the repository, or a new image is pushed to the registry, a webhook is triggered.
This webhook triggers a script that pulls the latest changes, rebuilds the images and restarts the containers.

Each subdomain is setup differently, but they are usually setup as a reverse proxy, or as a static file server with a shared volume with nginx.

## Secrets

Several secrets are required for the system to work. These are not tracked by git.

The required files are:

- `atrellado.env`
  - Several secrets used to setup the Laravel application
- `auth.htpasswd`
  - Controls access to admin pages, like the docker registry
- `cert.crt`, `cert.key`
  - SSL certificate and key
- `commits.env`
  - `DB_URL`: Used to connect to the mongo database
  - `GH_APP_ID`, `GH_APP_PRIVATE_KEY`, `GH_INSTALLATION_ID`: Used to authenticate with GitHub
  - `POPULATE_KEY`: Used to authenticate when populating the database
  - Several secrets used to setup the node server
- `postgres.env`
  - Several secrets used to setup the postgres database
- `webhook.env`
  - `GH_SECRET`: Used to verify the GitHub webhook HMAC
