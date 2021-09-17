# SSH Port Forwarder for Docker

## Preparation

Create a directory for the SSH client configuration (see
`ssh_config(5)` for content and file formats) and generate a
passwordless key pair:

```
$ mkdir ssh
$ cd ssh
$ ssh-keygen -q -C "Port Forwarder" -N "" -f id_forwarder
```

Create a `ssh_config` file describing the remote host, authentication
and how ports are to be forwarded.  The container will connect to the
first `Host` named in the file.  If that entry is `Host *`, the
container will attempt to connect to `default`.

For example:
```
Host forward-to-my-server
  HostName some-server.example.com
  User someuser
  IdentitiesOnly true
  IdentityFile id_forwarder
  LocalForward 1234 127.0.0.1:5678
  GatewayPorts yes
  # Recommended.  DEBUG is helpful, too.
  LogLevel VERBOSE
```

On the remote host, add the following line to the remote account's
`authorized_keys` file, substituting the public key for the first line
and replacing `5678` with the destination port (lines broken for
readability):

```
ssh-rsa AAAA...VwxYZ test@example.com
    command="echo 'Port forwarding only'",no-port-forwarding,
    no-X11-forwarding,no-agent-forwarding,no-pty,permitopen="127.0.0.1:5678"
```    


## Docker

```
docker run -it --volume=/path/to/ssh/directory:/etc/ssh:ro --publish=1234:1234 markfeit/ssh-port-forwarder

```

## Docker Compose

```
services:

  ssh-forwarder:
    image: markfeit/ssh-port-forwarder:latest
    ports:
      - "1234:1234"
    restart: unless-stopped
    volumes:
      - ./ssh/directory:/etc/ssh
```
