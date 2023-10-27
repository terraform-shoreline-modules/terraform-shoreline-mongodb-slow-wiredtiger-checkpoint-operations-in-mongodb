

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