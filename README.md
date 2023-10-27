
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Slow WiredTiger Checkpoint Operations in MongoDB.
---
This incident type refers to a situation where MongoDB, a database management system, experiences slow WiredTiger checkpoint operations. WiredTiger is the default storage engine used in MongoDB. Checkpoint operations are used to save the current state of the database to disk. Slow checkpoint operations can cause performance issues and may result in slower response times or even downtime for the database. This type of incident can affect the availability and reliability of the database and may require immediate attention by the software engineer responsible for managing the database.

### Parameters
```shell
export MONGODB_DATA_DIRECTORY="PLACEHOLDER"

export CACHE_SIZE="PLACEHOLDER"

export STORAGE_ENGINE="PLACEHOLDER"

export CHECKPOINT_THRESHOLD="PLACEHOLDER"

export MONGODB_CONFIG_FILE="PLACEHOLDER"

export CHECKPOINT_INTERVAL="PLACEHOLDER"
```

## Debug

### Check MongoDB server status and get current WiredTiger statistics
```shell
mongo --eval "db.serverStatus().wiredTiger"
```

### Check disk usage and availability for MongoDB data directory
```shell
df -h ${MONGODB_DATA_DIRECTORY}
```

### Check MongoDB WiredTiger cache usage and eviction statistics
```shell
mongo --eval "db.serverStatus().wiredTiger.cache"
```

### Check MongoDB WiredTiger checkpoint statistics
```shell
mongo --eval "db.serverStatus().wiredTiger["checkpoint"]"
```

### Check MongoDB WiredTiger thread statistics
```shell
mongo --eval "db.serverStatus().wiredTiger["thread-yield"]"
```

### Check MongoDB WiredTiger transaction statistics
```shell
mongo --eval "db.serverStatus().wiredTiger["transaction"]"
```

## Repair

### Identify the root cause of slow checkpoint operations and optimize the configuration of MongoDB. This can involve tuning the checkpoint interval and checkpoint threshold values, adjusting the cache size, or changing the storage engine settings.
```shell


#!/bin/bash



# Set configuration parameters for MongoDB

MONGODB_CONFIG_FILE=${MONGODB_CONFIG_FILE}

CHECKPOINT_INTERVAL=${CHECKPOINT_INTERVAL}

CHECKPOINT_THRESHOLD=${CHECKPOINT_THRESHOLD}

CACHE_SIZE=${CACHE_SIZE}

STORAGE_ENGINE=${STORAGE_ENGINE}



# Stop MongoDB service

sudo systemctl stop mongodb



# Update configuration file

sudo sed -i "s/checkpointIntervalMs=.*/checkpointIntervalMs=$CHECKPOINT_INTERVAL/" $MONGODB_CONFIG_FILE

sudo sed -i "s/checkpointThreshold=.*/checkpointThreshold=$CHECKPOINT_THRESHOLD/" $MONGODB_CONFIG_FILE

sudo sed -i "s/cacheSizeGB=.*/cacheSizeGB=$CACHE_SIZE/" $MONGODB_CONFIG_FILE

sudo sed -i "s/storageEngine=.*/storageEngine=$STORAGE_ENGINE/" $MONGODB_CONFIG_FILE



# Start MongoDB service

sudo systemctl start mongodb


```