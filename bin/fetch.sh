#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

curl https://covid19sertifikats.lv/verify/keys | json > "$BASEDIR/../data/keys.json"
curl https://covid19sertifikats.lv/rules.json | json > "$BASEDIR/../data/rules.json"
curl https://covid19sertifikats.lv/verify/valueset | json > "$BASEDIR/../data/valueset.json"
curl https://covid19sertifikats.lv/verify.min.js | js-beautify -o "$BASEDIR/../data/verify.min.js"

git add "$BASEDIR/../data"

if ! git diff-index --quiet HEAD --; then
    echo "Huston, we have a changes!"
    git add "$BASEDIR/../data"
    git commit -m "changes arrived"
    git push origin main
fi
