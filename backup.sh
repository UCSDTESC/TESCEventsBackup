#!/bin/sh
set -e

HOST=$MONGO_HOST
DB=$MONGO_DB
USER=$MONGO_USER
PASSWORD=$MONGO_PASSWORD
URI="mongodb://$USER:$PASSWORD@$HOST/$DB?ssl=true&replicaSet=atlas-12kcec-shard-0&authSource=admin&retryWrites=true&w=majority"

S3_BUCKET=$S3_BUCKET

S3PATH="s3://$S3_BUCKET/$DB/"
DATE=`date -u +"%Y-%m-%dT%H%M%SZ"`
S3BACKUP=$S3PATH$DATE.dump.gz
S3LATEST=$S3PATH"latest".dump.gz
/usr/bin/aws s3 mb $S3PATH

# Create dump and save in file $DATE.dump.gz
/usr/bin/mongodump --uri $URI --gzip --archive=$DATE.dump.gz

# Upload new dump to s3 as $Date.dump.gz AND latest.dump.gz
aws s3 cp $DATE.dump.gz $S3BACKUP
aws s3 cp $S3BACKUP $S3LATEST

# Restore
# echo -n "Restore: "
# echo -n "aws s3 cp $S3LATEST - | mongorestore -h $HOST -d $DB -u [USER] -p [PASSWORD] --archive --gzip "
