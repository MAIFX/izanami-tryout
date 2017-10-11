# Try Izanami in 5 minutes

What you will need :

* docker
* git
* 5 minutes of your time

# The elevator pitch

Izanami is a shared configuration service well-suited for micro-service architecture implementation. In addition to shared configuration, Izanami provides feature flipping and A/B Testing. Izanami provides a UI to allow non-tech users to toggle features and to handle A/B testing.

Izanami also provides first class integration. We provide Java, Scala, Node and React clients to integrate with your apps. We also provide webhook integration.

Want more? go to https://www.opunmaif.fr/#izanami

# Use it

## Build the container

```zsh
git clone https://github.com/MAIFX/izanami-tryout.git --depth=1
# go to your cloned izanami tryout folder
cd ./izanami-tryout/
# then build and run the docker image
docker build -t izanami .
```

## Run default

```zsh

docker run -p "8080:8080" -d izanami
# you can run 'docker logs xxxxx -f' to follow Izanami logs
```

Then open your favorite browser and go to http://localhost:8080

You can login with admin/admin1234

Enjoy :)

## Run with Redis

```zsh
# First run the redis container
docker run -d --name redis redis

# Run izanami.
# We need to link izanami to redis and pass the env IZANAMI_DATABASE=Redis
docker run --link redis:redis -e IZANAMI_DATABASE=Redis -e IZANAMI_EVENT_STORE=Redis -p "8080:8080" -d izanami
```


## Run with cassandra

```zsh
export IZANAMI_PORT=8080

# First run the cassandra container
docker run -d --name cassandra -e CASSANDRA_LISTEN_ADDRESS=localhost cassandra

# Run izanami.
# We need to link izanami to redis and pass the env IZANAMI_DATABASE=Cassandra
docker run --link cassandra:cassandra -e IZANAMI_DATABASE=Cassandra -p "$IZANAMI_PORT:8080" -d izanami
```


## Configure distributed events

If you have to run multiple instance of izanami, you have to share the events between instances.
You can use redis pub/sub, kafka or akka cluster.

### Akka distributed pub sub

```zsh
export IZANAMI_PORT=8080

# First run the cassandra container
docker run -d --name cassandra -e CASSANDRA_LISTEN_ADDRESS=localhost cassandra

# Run izanami instance 1.

docker run --name izanami --link cassandra:cassandra -e IZANAMI_DATABASE=Cassandra -e IZANAMI_EVENT_STORE=Distributed -p "8080:8080" -d izanami

# Run izanami instance 2.

docker run --name izanami2 --link cassandra:cassandra -e IZANAMI_DATABASE=Cassandra --link izanami:izanami -e IZANAMI_EVENT_STORE=Distributed -p "8081:8080" -d izanami

```

### Redis

```zsh
# First run the redis container
docker run -d --name redis redis

# Run izanami.
# We need to link izanami to redis and pass the env IZANAMI_DATABASE=Redis
docker run --link redis:redis -e IZANAMI_DATABASE=Redis -e IZANAMI_EVENT_STORE=Redis -p "8080:8080" -d izanami
```

### Kafka
```zsh
# First run the kafka container
docker run --name kafka -d spotify/kafka

# Then run the kafka container
docker run -d --name cassandra cassandra

# Run izanami instance 1.

docker run --link cassandra:cassandra --link kafka:spotify/kafka -e IZANAMI_DATABASE=Cassandra -e IZANAMI_EVENT_STORE=Kafka  -p "8080:8080" -d izanami

```


# But I don't want to use Docker

Yeah, I understand :)

if you have a JDK 8 installed, you can do the following

```zsh
git clone https://github.com/MAIFX/izanami-tryout.git --depth=1
cd ./izanami-tryout/
unzip opun-izanami-1.0.0-SNAPSHOT.zip
cd opun-izanami-1.0.0-SNAPSHOT
./bin/opun-izanami -Dconfig.file=./conf/docker.conf -Dlogger.file=./conf/prod-logger.xml
```

# But it doesn't work :'(

Please create issues if your encounter any problem or if you have questions
