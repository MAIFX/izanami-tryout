# Try Otoroshi in 5 minutes

what you will need :

docker
git
5 minutes of free time

# The elevator pitch

Izanami is an awesome shared config / feature / AB testing service built in scala that can improve easily the business of your product.

# Use it

```
export IZANAMI_PORT=8080

git clone https://github.com/MAIFX/izanami-tryout.git --depth=1
# go to your cloned otoroshi tryout folder
cd ./izanami-tryout/
# then build and run the docker image
docker build -t izanami .
docker run -p "$IZANAMI_PORT:8080" -d izanami
# you can run 'docker logs xxxxx -f' to follow Izanami logs
```

Then open your favorite browser and go to http://localhost:8080

Enjoy :)

# But I don't want to use Docker

Yeah, I understand :)

if you have a JDK 8 installed, you can do the following

git clone https://github.com/MAIFX/otoroshi-tryout.git --depth=1
cd ./izanami-tryout/
unzip opun-izanami-1.0.0-SNAPSHOT.zip
cd opun-izanami-1.0.0-SNAPSHOT
./bin/opun-izanami -Dconfig.file=./conf/docker.conf -Dlogger.file=./conf/prod-logger.xml

# But it doesn't work :'(

please create issues if your encounter any problem or if you have questions
