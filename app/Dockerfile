#
# Application
#

RUN apk add openssh-client-default

COPY app ./app

# Don't need this.
RUN rm -f ./app/Dockerfile

RUN adduser -g "Port Forwarder" -D forwarder
USER forwarder

# This may get changed if anyting is included later
ENTRYPOINT ["./app/run"]
