#!/bin/bash 
URL="https://mailfud.org/geoip-legacy"
FILES="GeoIP GeoIPv6 GeoIPCity GeoIPCityv6 GeoIPASNum GeoIPASNumv6"
TODAY="$(date -I | sed -E "s/-//g")"

cd $GITHUB_WORKSPACE ;
git fetch --depth=1 ;
git checkout database-files ;
rm sha256sums.txt ;

for FILE in $FILES ; do
	curl $URL/$FILE.dat.gz -o $FILE.dat.gz ;
	sha256sum $FILE.dat.gz >> sha256sums.txt ;
	git add $FILE.dat.gz ;
done
git add sha256sums.txt ;

# upload to github
git config user.name "robot-$GITHUB_ACTOR" ;
git commit -m "automated commit: $TODAY" ;
git tag -m "automated commit on $(date)" -a $TODAY HEAD ;
git push --tags ;
