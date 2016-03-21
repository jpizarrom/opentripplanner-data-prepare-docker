# opentripplanner-data-prepare
build Graph.obj from .osm.pbf data (http://download.geofabrik.de)

## copy data.tar.gz
```
id=$(docker run -e REGION=chile -e PROFILE=bicycle -d jpizarrom/osrm-data-prepare-docker)
docker wait $id
docker cp $id:/tmp/data.tar.gz . && mv data.tar.gz data-`date +"%Y-%m-%d-%H-%M-%S"`.tar.gz
```

## upload to s3

```
docker run \
         -e SUB_REGION=south-america \
         -e REGION=chile \
         -e STORAGE_FLAVOR=s3 \
         -e AWS_S3_BUCKET=... \
         -e AWS_S3_BUCKET_PREFIX=... \
         -e AWS_ACCESS_KEY_ID=... \
         -e AWS_SECRET_ACCESS_KEY=... \
         -d jpizarrom/opentripplanner-data-prepare
```
