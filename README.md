# devpi-docker
You can setup your private pypi in one cmd.

## feature
- Pypi using devpi-server
- Support web page and search
- Using basic auth to protect your private package
- Devpi user is ready with the same credential as the basic auth


## build
Run `docker-compose build` in the home of this repo.

## ship
You can find the docker image on [DockerHub](https://hub.docker.com/r/wushaobo/devpi-server/).

## run
1. Modify docker-compose.yml with the user name and password you would like, as well as the port forwarding.
2. Auto deploy (or manually copy) the docker-compose.yml to the target server.
3. Run `docker-compose -f docker-compose.yml up -d`

## verify
- When opening web page, basic auth (`demouser:demopwd`) will be required.
- When executing `devpi use ADDRESS` cmd, the ADDRESS has to be with basic auth
- When executing `devpi login USER_NAME`, the PASSWORD works.
- When installing pip package, you have to use extra index, like `--extra-link-url=http://demouser:demopwd@127.0.0.1:3141/demouser/dev/+simple`
