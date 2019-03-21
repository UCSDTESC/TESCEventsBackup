# TESC Events Backup

### Docker container for backing up Mongo to S3

## Usage

This script was designed to run on an AWS ECS/EC2 instance with the proper permissions to access the specified S3 bucket. AWS permissions should be injected automatically by the ECS task runner or can be configured before running the script on the EC2 instance.

To restore from the dump file use the following command:

```mongorestore -h $MONGO_HOST -d $MONGO_DB -u $MONGO_USER -p $MONGO_PASSWORD --archive --gzip latest.dump.gz```

## Configuration

The shell script requires the following environment variables:
- `MONGO_HOST` The host and port of the Mongo server
- `MONGO_DB` The database of the Mongo server to dump
- `MONGO_USER` The username used to connect to the Mongo server
- `MONGO_PASSWORD` The password associated with the username
- `S3_BUCKET` The name of the S3 bucket hosted in the same account as the ECS instance
