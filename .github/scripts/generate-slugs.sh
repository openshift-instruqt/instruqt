#!/bin/bash
# Scans a directory of tracks and creates a track-slugs.yml file
set -euo pipefail

cd $TRACK_DIR

# Clear track-slugs.yml
echo "---" > track-slugs.yml
echo "tracks:" >> track-slugs.yml

# Gather track.yml data
FOLDERS="developing-on-openshift developing-with-kogito developing-with-quarkus developing-with-spring developing-with-vertx enterprise-java gitops kafka operatorframework persistence playgrounds serverless servicemesh subsystems using-the-cluster"

for TOPIC in $FOLDERS; do
  pushd ../$TOPIC
  for dir in $(ls -d */); do
    if [ -f $dir/track.yml ];
    then
      echo "Adding $TOPIC/$dir to track-slugs"
      yq '"  - { slug: " + .slug + ", id: " + .id + " }"' ${dir}track.yml >> ../$TRACK_DIR/track-slugs.yml
    fi
  done
  popd
done

# Checking for duplicates
if [[ $(sort track-slugs.yml | uniq -D | wc -l) -gt 0 ]]; then
  echo "\n\nDuplicates detected!\n\n"
  sort track-slugs.yml | uniq -D
  exit 1
fi
