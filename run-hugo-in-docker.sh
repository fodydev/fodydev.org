#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run -it --rm --name hugo-todo \
  -v ${DIR}:/src/ \
  -v ${DIR}/run-hugo.sh:/run-hugo.sh \
  -w /src/ \
  -p 1313:1313 \
  eclipsefdn/hugo-node:h0.120.4-n18.19.1 \
  /run-hugo.sh
