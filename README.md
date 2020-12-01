# TESC Events Backup

### Docker container for backing up MongoDB Atlas to S3

## About

This script was originally designed to run on an AWS ECS/EC2 instance with the proper permissions to access the specified S3 bucket. Now, the script is run using Github Actions.

## Usage

The Github workflow will run every day at 0:00 UTC time. To manually run the workflow: 
1. Click on the "Actions" tab.
2. Select the "create-backup" workflow.
3. Click the "Run workflow" button and run the workflow using the master branch.

To restore from the dump file, ensure that you have installed [MongoDB Database Tools](https://docs.mongodb.com/database-tools/installation/installation/). Download `latest.dump.gz` from AWS S3 and run the following command:

```mongorestore --uri mongodb+srv://<username>:<password>@<host> --gzip --archive=latest.dump.gz```

This command can be found in Atlas by clicking on your cluster and finding "Command Line Tools". Note that this command assumes you have the latest version of MongoDB Tools installed on your local machine.

## Configuration

The shell script requires the following environment variables:
- `AWS_ACCESS_KEY_ID` The access key ID of the AWS user who has access to the S3 bucket
- `AWS_SECRET_ACCESS_KEY` The secret access key associated with the access key ID
- `MONGO_HOST` The host and port of the Mongo server
    - This was obtained by clicking the "CONNECT" button on the targeted cluster in Atlas, choosing "Connect your application", and selecting the driver as "Node.js" with version 2.2.12 or later.
    - It should look something (maybe not exactly) like this: `mongodb://<username>:<password>@<cluster/shard>.mongodb.net:27017,<cluster/shard>.mongodb.net:27017,<cluster/shard>.mongodb.net:27017/<dbname>?ssl=true&replicaSet=atlas-12kcec-shard-0&authSource=admin&retryWrites=true&w=majority`
    - Everything after the `@` and before `/<dbname>` should be entered as the `MONGO_HOST`.
- `MONGO_DB` The database of the Mongo server to dump
- `MONGO_USER` The username used to connect to the Mongo server
- `MONGO_PASSWORD` The password associated with the username
- `S3_BUCKET` The name of the S3 bucket

These environment variables are stored as secrets in the Github repo.