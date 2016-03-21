#! /bin/bash

set -e
mkdir -p /data/graphs/default/
$CMD_1
$CMD_2
$CMD_3
$CMD_4
wget http://download.geofabrik.de/$SUB_REGION/$REGION$REGION_FILENAME_SUFFIX$REGION_FILENAME_EXTENSION -O /data/graphs/default/$REGION$REGION_FILENAME_SUFFIX$REGION_FILENAME_EXTENSION

java $JAVA_OPTS -jar /var/otp/otp.jar --build /data/graphs/default/

tar czvf /tmp/data.tar.gz -C /data/graphs/default Graph.obj

if [[ "$STORAGE_FLAVOR" == "s3" ]]; then
   aws s3 cp /tmp/data.tar.gz s3://$AWS_S3_BUCKET$AWS_S3_BUCKET_PREFIX/$SUB_REGION/$REGION/$REGION$REGION_FILENAME_SUFFIX-`date +"%Y-%m-%d-%H-%M-%S"`-$OTP_VERSION.tar.gz
fi
