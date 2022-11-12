# IIHF Hackathon Challenge

This is the repository for IIHF Blockchain Challenge. Below listed is the information needed to use and run the template project provided by the challenge owners.

## General Info

The repository consists of three main applications:

    - `.lib` folder: Code to run and edit the frontend
    - `accessRequest.sol`: Smart Contract Template to handle accessRequests from scout and athletes
    - `<INSERT_DATABASE>`: The database solution with some sample data

## How to run

Start docker daemon

```
dockerd
```

Build image from Dockerfile

```
docker build -t unifiedbackend .
```

and run it

```
docker run -it --rm unifiedbackend
```

`-it` keeps an interactive terminal open
`--rm` automatically removes the container when it terminates

To run it in the background replace `-it` with `-d`
Map ports with `-p [host_port]:[container port]` (8080 is exposed in container)
Use host network with `--network=host`
Name the container with `--name [name]`

## Docker Stages

The docker file provides the following stages:

- test
- build
- deploy

Stop the image build at a specific stage by providing the
`--target [stage]` flag

To skip stages use buildkit:
`DOCKER_BUILDKIT=1 [docker command]`

## Common commands

`go mod download && go mod tidy` should fix import issues
