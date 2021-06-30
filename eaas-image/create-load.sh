#!/bin/sh
set -eu

URL="http://localhost:8080"

# Does a GET request to the given URL and discards all data
do_get() {
    echo "GET $1" >&2
    # -4 is a workaround for https://github.com/curl/curl/issues/5080
    curl -4 --connect-timeout 10 --retry 20 --retry-delay 5 --retry-connrefused -sSf -o /dev/null "$1"
}

# Does a POST request to the given URL, then sleeps 1 second and outputs the URL the server redirects to
do_post() {
    echo "POST $1: $2" >&2
    curl -4 --connect-timeout 10 --retry 20 --retry-delay 5 --retry-connrefused -sSf -w '%{redirect_url}' -X POST -d "$2" "$1"
    sleep 1
}

do_get "$URL/"
do_get "$URL/owners/new"
harry_potter_url="$(do_post "$URL/owners/new" "firstName=Harry&lastName=Potter&address=4+Privet+Drive&city=Little+Whinging%2C+Surrey&telephone=%2B123456789")"

# Sleeps are completely arbitrary and not necessary; we just don't want to run in a busy loop
while true; do
    do_get "$URL/"
    do_get "$URL/owners?lastName="
    do_post "$harry_potter_url/pets/new" "id=&name=Hedwig&birthDate=2000-01-01&type=bird" >/dev/null
    do_get "$URL/owners/find"
    do_get "$URL/owners?lastName=Potter"
    do_get "$harry_potter_url"
    sleep 1
    do_post "$URL/owners/new" "firstName=Petunia&lastName=Dursley&address=4+Privet+Drive&city=Little+Whinging%2C+Surrey&telephone=%2B123456790" >/dev/null
    do_get "$URL/owners?lastName=Dumbledore"
    do_get "$URL/vets.html"
    sleep 2
done
