# kubernetes-examples

Configuration Examples for Kubernetes and Docker.
All YAML files should be checked and, if necessary, adapted to the environment.


## Requirement

*  You have experience with Docker
*  You have already installed Docker
*  You already have a Kubernetes setup
*  You have your own docker registry

## Build Dockerfile

If you want to build Docker image, you can do it so:

    cd into/the/docker-drupal/dir
    docker build -t drupal .

this created a image with the name 'drupal'

If you want to push the image to your local reposetory, you can do it so:

    docker tag drupal 1.2.3.4:5000/drupal
    docker push 1.2.3.4:5000/drupal

This commands pushing the image into the registry with the ip 1.2.3.4 running on port 5000.


## Configuration replacement

please watch out for following strings or definitions in kubernetes and docker configuration.

### DOCKER_REGISTRY

this parameter are the placeholder for the fqdn or ip address of the docker registry.



