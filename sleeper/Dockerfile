FROM ubuntu:18.10
ADD hi /tmp
ADD entry-point.sh /tmp
RUN chmod +x /tmp/entry-point.sh

ARG BUILD_ENV=prod
RUN if [ "${BUILD_ENV}" = "dev" ]; then mv /tmp/hi /tmp/hiGotRenamedToHello; fi
ENTRYPOINT ["/tmp/entry-point.sh"]
