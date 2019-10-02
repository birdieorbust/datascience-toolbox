#!/bin/bash
set -e

if [ "$#" -eq 0 ]
  then
    rstudio-server start
#    jupyter lab --ip=0.0.0.0 --allow-root --no-browser &> /dev/null &
#    code-server1.1156-vsc1.33.1-linux-x64/code-server --allow-http --install-extensions dojayamanne.python-extensions-pack --no-auth --user-data-dir /data /code
  else
    exec "$@"
fi
