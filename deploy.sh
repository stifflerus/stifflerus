#!/bin/bash

set -e

echo "Building site...";
jekyll build;

echo "Deploying...";
rsync -r ./_site/ root@stiffler.us:/var/www/stiffler.us/
