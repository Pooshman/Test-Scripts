#!/bin/bash

# Variables
CLUSTER_NAME="my-new-cluster-2"
QUEUE_NAME="queue-1"  # The name of your Slurm queue
COMPUTE_RESOURCE="queue-1-cr-1"  # The name of your compute resource within the queue
MIN_NODES=0  # Minimum number of nodes (can be 0 to allow scaling down to zero)
MAX_NODES=10  # Maximum number of nodes
DESIRED_NODES=5  # The desired number of nodes you want to scale to

# Function to scale up the nodes
scaleUp() {
  aws parallelcluster update-compute-fleet \
    --cluster-name $CLUSTER_NAME \
    --compute-resources \
    "[{\"Name\":\"$COMPUTE_RESOURCE\",\"MinCount\":$MIN_NODES,\"MaxCount\":$MAX_NODES,\"DesiredCount\":$DESIRED_NODES}]" \
    --queue-name $QUEUE_NAME \
    --region us-east-1
}

# Call the function
scaleUp

# Check if the scaling was successful
if [ $? -eq 0 ]; then
  echo "Successfully scaled the compute nodes to $DESIRED_NODES."
else
  echo "Failed to scale the compute nodes."
fi
