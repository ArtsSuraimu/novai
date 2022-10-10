#!/bin/bash

source /root/.bashrc && nohup npm run serve --prefix /workspace/novelai-sample &

cd sd-private/hydra-node-http && gunicorn main:app --workers 1 --worker-class uvicorn.workers.UvicornWorker --bind 0.0.0.0:80 --timeout 0 --keep-alive 60 --log-level=debug
