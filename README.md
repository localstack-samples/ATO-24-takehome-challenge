[![Launch LocalStack Cloudpod](https://localstack.cloud/gh/launch-pod-badge.svg)](https://app.localstack.cloud/launchpad?url=https://raw.githubusercontent.com/localstack-samples/ATO-24-takehome-challenge/main/localstack-cloud-pod)

# Building the take-home challenge for ATO 2024

How to rebuild the project after making changes to it.

1. Export your auth token:
   `export LOCALSTACK_AUTH_TOKEN=your_token`
2. Start LocalStack
   `localstack start`
3. Run the following script to clean up any Terraform state tracking files:
   `bash cleanup.sh`
4. Run the following script to create the resources via Terraform:
   `bash run-tf.sh`
5. Export state locally by creating the cloud pod:
   `localstack state export localstack-cloud-pod`
   Make sure the name is the same, so you don't have to create a new link via the Launchpad
   Push the cloud pod and the changes to the repository
6. If you want to change the cloud pod name, go to http://app.localstack.cloud/launchpad and put in the following link:
