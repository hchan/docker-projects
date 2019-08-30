# note that BUILD_ENV is an environment file
# if it is set to "dev", a file called /tmp/hiGotRenamedToHello will exist
# otherwise only /tmp/hi will be there
docker build -t my-sleeper . --build-arg BUILD_ENV
