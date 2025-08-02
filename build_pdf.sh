#!/bin/bash

CWD=`pwd`
cd _site
COUNT=1
SANDBOX=true


if [ -n "$1" ] && [ "$1" = 'false' ]; then
    SANDBOX=false
fi

echo "SANDBOX=$SANDBOX"

for i in `ls | grep .html | grep '-'`; do
    puppeteer screenshot --sandbox $SANDBOX $i page_screenshot_$COUNT.png
    COUNT=$(( COUNT + 1 ))
done

TITLE=Yolo_Kitchen_Recipes_cooking.yolocitrus.com

pipenv run img2pdf page_screenshot_*.png -o $TITLE.pdf --title $TITLE --creationdate $(date +%Y-%m-%dT%H:%M:%S) --keywords cooking --keywords kitchen --keywords recipes

rm -v page_screenshot_*.png

cd -

echo "Complete pdf generation"
