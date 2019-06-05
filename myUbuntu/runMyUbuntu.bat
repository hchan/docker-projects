@REM docker run -v c:/:/data  -it my-ubuntu bash
docker run -d -p 22222:22 -p 25901:5901 -v c:/:/data  my-ubuntu
