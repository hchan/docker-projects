@REM docker run -v c:/:/data  -it my-ubuntu bash
docker run -d -p 22222:22 -p 25901:5901 -p 18888:18888 -v c:/:/data --cap-add=NET_ADMIN my-ubuntu
echo "Please use a vnc client @ localhost:25901"
