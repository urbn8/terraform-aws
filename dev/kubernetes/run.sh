#!/bin/bash
set -eo pipefail

if [[ $1 == 'destroy' ]]; then
	mv main.tf main.bk
	terraform destroy
	mv main.bk main.tf
fi

if [[ $1 == 'prepare' ]]; then
	export KOPS_STATE_STORE=$(terraform output state_store)
	export ZONES="eu-central-1a,eu-central-1b,eu-central-1c"
	export MASTER_ZONE="eu-central-1a,eu-central-1b,eu-central-1c"
	export CLUSTER_MASTER_SIZE="t2.nano"
	export CLUSTER_NODE_SIZE="t2.nano"
	export K8S_VERSION="1.9.6"
	export CLUSTER_NODE_COUNT="3"
	export CLUSTER_MASTER_COUNT="3"
	export AWS_KEYPAIR_PUB_KEY_PATH="~/.ssh/id_rsa.pub"

	export NAME=$(terraform output cluster_name)
	cd ../vpc
	export VPC_ID=$(terraform output vpc_id)
	cd -

fi