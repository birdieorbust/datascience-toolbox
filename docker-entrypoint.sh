#!/bin/bash
set -e

if [ "$#" -eq 0 ]
  then
#    rstudio-server start
    jupyter lab --ip=0.0.0.0 --NotebookApp.token='local-development' --allow-root --no-browser &> /dev/null &
    opt/code-server/code-server --disable-telemetry --allow-http --no-auth --user-data-dir /data /code --extensions-dir /home/ubuntu/.local/share/code-server/extensions
  else
    exec "$@"
fi
