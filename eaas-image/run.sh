#!/bin/sh
set -eu

# Allow analysis-service some time to start
sleep 10

java-with-kieker -cp ".:BOOT-INF/classes/:BOOT-INF/lib/*" org.springframework.samples.petclinic.PetClinicApplication &

# Now create some load on the server so we will have an interesting visualization
./create-load.sh
