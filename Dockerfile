#
# THIS FILE IS GENERATED.  DO NOT EDIT.
#


# Dockerfile Header for markfeit/ssh-port-forwarder

FROM alpine:latest
LABEL maintainer "Mark Feit <mfeit+docker@notonthe.net>"

WORKDIR /container/markfeit/ssh-port-forwarder
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


#
# THE END 
#
