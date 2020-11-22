#!/bin/bash
if  ! command -v docker &>/dev/null; then
    echo -e "Docker not installed"
fi


cd $(realpath $0 |sed 's,/*[^/]\+/*$,,')/..
ls -lah && docker build -t bento .
docker run --user tamago -p 8080:8080 -e DISPLAY=$(hostname -I):0.0 -it bento