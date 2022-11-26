# IIHF Hackathon Challenge

This is the repository for IIHF Blockchain Challenge. Below listed is the information needed to use and run the template project provided by the challenge owners.

## General Info

The repository consists of three main applications:

`.\lib` folder: Code to run and edit the frontend <br /><br />
`accessRequest.sol`: Smart Contract Template to handle accessRequests from scout and athletes <br /><br />
`.\db`: The database folder that contains all files necessary to get the database running <br />

## How to run Frontend

Start docker daemon

```
dockerd
```

Build image from Dockerfile

```
docker build -t iihf-hackathon .
```

and run it

```
docker run -d -p 8080:80 --name iihf-hackathon iihf-hackathon
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

## How to run Database

Execute shell script

```
db_init.sh
```

The script will create a new docker container with the MYSQL-DB, running on `localhost:3306` with `user=myuser` and no password

## Athlete to wallet mapping

- "Simon KNAK" : "0x3953aE615bE1bD9379B29e87f4BB2f832C2ffeF2"
- "Emil ANDRAE" : "0x534b6237D8dCAb93ad08bB40d87F9D2Ec0625c90"
- "Kasper SIMONTAIVAL" : "0xB7307f388ebFFFff418E1c381b47F67b57Ed5eD4"
- "Jan MYSAK" : "0xFD01FfFF3dCF6f70107cc39a2f4bF4AC7Af82192"
- "Leon WALLNER" : "0x1797f7ca4D9478721a68299c640780DD1d20f611"
