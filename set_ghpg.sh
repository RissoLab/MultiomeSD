#!/bin/bash

# Assicurati di avere il sito aggiornato
# quarto render made on docker

# from qwebsite
# Salva il branch corrente per tornarci dopo
CURRENT_BRANCH=$(git branch --show-current)
cp -r _site ../tmp_site
# Evita Jekyll
touch ../.nojekyll

# Passa a gh-pages
git checkout gh-pages
cp -r ../tmp_site/* .

# Commit e push
git add .
git commit -m "Aggiorna sito da $(date)"
git push origin gh-pages

# Torna al branch di partenza
git checkout "$CURRENT_BRANCH"
