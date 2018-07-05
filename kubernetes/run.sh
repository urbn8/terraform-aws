#!/bin/bash
set -eo pipefail

export NAME=$(terraform output cluster_name)
export KOPS_STATE_STORE=$(terraform output state_store)
export ZONES=$(terraform output -json zones | jq -r '.value|join(",")')
cd ../
export VPC_ID=$(terraform output vpc_id);
cd -
export CLUSTER_MASTER_SIZE="t2.nano"
export CLUSTER_NODE_SIZE="t2.nano"
export K8S_VERSION="1.9.6"
export CLUSTER_NODE_COUNT="2"
export AWS_KEYPAIR_PUB_KEY_PATH="~/.ssh/id_rsa.pub"


kops create cluster \
    --master-zones=$ZONES \
    --zones=$ZONES \
    --topology private \
    --dns-zone=${NAME} \
    --networking=calico \
    --vpc=${VPC_ID} \
    --master-size=${CLUSTER_MASTER_SIZE} \
    --node-size=${CLUSTER_NODE_SIZE} \
    --node-count=${CLUSTER_NODE_COUNT} \
    --ssh-public-key=${AWS_KEYPAIR_PUB_KEY_PATH} \
	--kubernetes-version=${K8S_VERSION} \
    --name=${NAME} \
    --out=. \
    --target=terraform