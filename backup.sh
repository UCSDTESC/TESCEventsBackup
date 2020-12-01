#!/bin/sh
set -e

HOST=$MONGO_HOST
DB=$MONGO_DB
USER=$MONGO_USER
PASSWORD=$MONGO_PASSWORD
URI="mongodb+srv://$USER:$PASSWORD@$HOST/$DB"

S3_BUCKET=$S3_BUCKET

S3PATH="s3://$S3_BUCKET/$DB/"
S3BACKUP=$S3PATH`date -u +"%Y-%m-%dT%H%M%SZ"`.dump.gz
S3LATEST=$S3PATH"latest".dump.gz
/usr/bin/aws s3 mb $S3PATH

# /usr/bin/mongodump -h $HOST -d $DB -u $USER -p $PASSWORD --gzip --archive | aws s3 cp - $S3BACKUP
/usr/bin/mongodump --uri "$URI" --gzip --archive | aws s3 cp - $S3BACKUP
aws s3 cp $S3BACKUP $S3LATEST

# Restore
# echo -n "Restore: "
# echo -n "aws s3 cp $S3LATEST - | mongorestore -h $HOST -d $DB -u [USER] -p [PASSWORD] --archive --gzip "
