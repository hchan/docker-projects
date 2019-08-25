# See https://github.com/alpine-docker/socat
# After this runs
# Open your browser and goto http://localhost:4321
$IMAGE_MY_UBUNTU=`docker ps -f "ancestor=my-ubuntu" --format "{{.ID}}"`;
chop $IMAGE_MY_UBUNTU;
$LOCAL_PORT=4321;
$NGINX_PORT=80;
`docker run --publish $LOCAL_PORT:$NGINX_PORT --link $IMAGE_MY_UBUNTU:target alpine/socat tcp-listen:$NGINX_PORT,fork tcp-connect:target:$NGINX_PORT`;

