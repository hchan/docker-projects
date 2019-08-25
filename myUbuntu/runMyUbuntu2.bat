@REM docker run -v c:/:/data  -it my-ubuntu bash
docker run -d -p 25902:5901  -v c:/:/data --cap-add=NET_ADMIN my-ubuntu
echo "Please use a vnc client @ localhost:25901"
