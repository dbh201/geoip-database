#!/bin/bash 
URL="https://mailfud.org/geoip-legacy"
FILES="GeoIP GeoIPv6 GeoIPCity GeoIPCityv6 GeoIPASNum GeoIPASNumv6"
TODAY="$(date -I | sed -E "s/-//g")"

cd $GITHUB_WORKSPACE ;
git checkout database-files ;
rm sha256sums.txt ;

for FILE in $FILES ; do
	curl $URL/$FILE.dat.gz -o $FILE.dat.gz ;
	sha256sum $FILE.dat.gz >> sha256sums.txt ;
done

# upload to github
git add . ;
git config user.name "$GITHUB_ACTOR" ;
git commit -m "automated commit: $TODAY" ;
git tag -m "automated commit on $(date)" -a $TODAY HEAD ;
git push ;
