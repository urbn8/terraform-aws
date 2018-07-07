#!/bin/bash
set -eo pipefail

export NAME=$(terraform output cluster_name)
export KOPS_STATE_STORE=$(terraform output state_store)
#export ZONES=$(terraform output -json zones | jq -r '.value|join(",")')
export ZONES="eu-central-1a,eu-central-1b,eu-central-1c"
export MASTER_ZONE="eu-central-1a"
#export SECURITY_GROUP="sg-8abe6ce6,sg-a9b96bc5,sg-68b96b04,sg-8bbe6ce7"
export SECURITY_GROUP=$(terraform output security_group_id)
cd ../
export VPC_ID=$(terraform output vpc_id);
cd -
export CLUSTER_MASTER_SIZE="t2.micro"
export CLUSTER_NODE_SIZE="t2.micro"
export K8S_VERSION="1.9.6"
export CLUSTER_NODE_COUNT="3"
export CLUSTER_MASTER_COUNT="1"
export AWS_KEYPAIR_PUB_KEY_PATH="~/.ssh/id_rsa.pub"

MESSAGE="Build kubenetes with command: 
    kops create --master-zones=$MASTER_ZONE
    --zones=$ZONES
    --dns-zone=${NAME}
    --vpc=${VPC_ID}
    --master-size=${CLUSTER_MASTER_SIZE}
    --node-size=${CLUSTER_NODE_SIZE}
    --node-count=${CLUSTER_NODE_COUNT}
    --master-count=${CLUSTER_MASTER_COUNT}
    --master-security-groups=${SECURITY_GROUP}
    --ssh-public-key=${AWS_KEYPAIR_PUB_KEY_PATH}
    --kubernetes-version=${K8S_VERSION}
    --cloud=aws
    --name=${NAME}
    "
curl -s 'http://consul.staging.rcapp.co:8500/v1/kv/terraform/slack?dc=staging&raw=true' | bash -s "$MESSAGE"
echo "$MESSAGE"

kops create cluster \
    --master-zones=$MASTER_ZONE \
    --zones=$ZONES \
    --dns-zone=${NAME} \
    --vpc=${VPC_ID} \
    --master-size=${CLUSTER_MASTER_SIZE} \
    --node-size=${CLUSTER_NODE_SIZE} \
    --node-count=${CLUSTER_NODE_COUNT} \
    --master-count=${CLUSTER_MASTER_COUNT} \
    --master-security-groups=${SECURITY_GROUP} \
    --ssh-public-key=${AWS_KEYPAIR_PUB_KEY_PATH} \
	--kubernetes-version=${K8S_VERSION} \
    --cloud=aws \
    --name=${NAME}
