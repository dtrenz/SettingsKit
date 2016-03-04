#!/usr/bin/env bash

set -e # exit with nonzero exit code if anything fails

# clear and re-create the out directory
rm -rf docs || exit 0;
mkdir docs;

# generate docs
jazzy \
  --clean \
  --author "Dan Trenz" \
  --github_url https://github.com/dtrenz/SettingsKit \
  --module-version 0.1.0 \
  --xcodebuild-arguments -scheme,SettingsKit \
  --module SettingsKit \
  --output docs

# go to the out directory and create a *new* Git repo
cd docs
git init

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
git add .
git commit -m "Deploy to GitHub Pages"

# Force push from the current repo's master branch to the remote
# repo's gh-pages branch. (All previous history on the gh-pages branch
# will be lost, since we are overwriting it.) We redirect any output to
# /dev/null to hide any sensitive credential data that might otherwise be exposed.
git push --force --quiet "https://github.com/dtrenz/SettingsKit" master:gh-pages > /dev/null 2>&1
