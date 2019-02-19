#!/bin/bash -e

case "$1" in
  pipenv)
    pipenv install
    ;;
  jupyter)
    .venv/bin/jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root
    ;;
  *)
    exec "$@"
esac