#!/bin/bash

DOC_REPO="security-lab"

make html

git clone "ssh://git@pagure.io/docs/$DOC_REPO.git"
cp -r _build/html/* $DOC_REPO/
(
    cd $DOC_REPO
    git add .
    git commit -av
    git push
)

rm -rfI _build
rm -rfI $DOC_REPO
