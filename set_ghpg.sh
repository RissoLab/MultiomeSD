#!/bin/bash

# quarto render # made on docker

# from qwebsite
CURRENT_BRANCH=$(git branch --show-current)
cp -r _site ../tmp_site
touch ../tmp_site/.nojekyll

if ! OUTPUT=$(git checkout gh-pages 2>&1); then
  echo "ERROR: git checkout gh-pages failed"
  echo "$OUTPUT"
  exit 1
fi

cp -r ../tmp_site/* .

git add .
git commit -m "Aggiorna sito da $(date)"
git push origin gh-pages

git checkout "$CURRENT_BRANCH"
