# ethereum-block-stats-aggregator
This bundle allows you to deploy a private network ethereum blockchain and built-on-top system of logging latest blocks in this network. 
Every app is executed in its own Docker container and configured using Dockerfiles and docker-compose.yml file.

# Prerequesties
1. First things first clone this repo into a directory of your choice:
```bash
git clone https://github.com/DmitriySolontsevoy/ethereum-block-stats-aggregator.git
```

2. After that you'll need to clone go-ethereum repo in the directory you choose in Step 1:
```bash
git clone https://github.com/ethereum/go-ethereum.git
```

3. Then you'll need to clone 2 apps. First one polls the block from the blockchain and publishes it to RMQ. Second reads the messages, inserts blocks into 
PSQL database and increments the counter within Redis. Target directory must match the one in Steps 1 and 2:
```bash
git clone https://github.com/DmitriySolontsevoy/blockchain-status-publisher.git
git clone https://github.com/DmitriySolontsevoy/blockchain-status-consumer.git
```

4. If you don't have Docker and Docker-compose installed, install them referring to this manual: https://docs.docker.com/compose/install/

# Launch
Now that you are all set up, you can start deployment by running the following command in your target directory shell or terminal:
```bash
docker-compose up
```

If you are using Linux-based OS and the above command is not working the issue might be in lacking rights of your current user. Try running it with 'sudo' prefix:
```bash
sudo docker-compose up
```

# Monitor the system (RMQ)
To monitor status of RMQ inside the system just use any browser you want and access RMQ Management UI to view the status of your system: "http://13.37.0.3:15672"
If you have IP or port of the RMQ service changed, input them instead of URL given above.

# Monitor the system (Redis)
To view the counter in Redis you'll need to enter Redis container and access the value from there:
1. Open the terminal (shell) in your target directory and run the following command:
```bash
docker exec -it redis redis-cli
```

2. You will enter the container, once inside (You'll see "127.0.0.1:6379>" before the carriage), query the key of a counter by using the following command:
```bash
get counter
```

3. Output will display the number of times the consumer inserted new records into the database.

# Monitor the system (PSQL)
To view DB contents you'll need to enter Postgres container and access DB from there:
1. Open the terminal (shell) in your target directory and run the following command:
```bash
docker exec -it postgres psql postgres postgres
```

2. Query the tables with following queries after you entered the container ("postgres-#" before the carriage):
```sql
select * from blocknumbers;
select * from blocktimes;
```

3. Output will display all records currently in the DB.

# Stopping the system
To stop the system, open the terminal, from which system was deployed, and press Ctrl+C.
To delete containers run:
```bash
docker-compose down
```

System has persistent volumes for all services, mounted to your target directories, so don't worry about data loss on container deletion.
List of mounted directories: 
* ethereum
* postgres-data
* redis-data
* rabbitmq-data
