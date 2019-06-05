for /f "tokens=*" %%n IN ('docker ps -q') do @(docker kill %%n)
