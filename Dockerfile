FROM ghcr.io/tubone24/depcheck_action/base:latest

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
