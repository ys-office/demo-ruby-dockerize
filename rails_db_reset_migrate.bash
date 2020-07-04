#! /bin/bash

docker-compose run --user "$(id -u):$(id -g)" drkiq rake db:reset \
&& docker-compose run --user "$(id -u):$(id -g)" drkiq rake db:migrate

exit ${?}
