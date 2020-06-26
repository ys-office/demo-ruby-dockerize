#! /bin/bash -x

docker run -it \
    -v ${PWD}:/opt/app \
    rails-toolbox rails new --skip-bundle drkiq

exit ${?}
