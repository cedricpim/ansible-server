# ansible-server

## How to Use

There is a Makefile to allow short commands for each playbook.

```
$ make setup
```

Used for setting the initial user, SSH keys and some personal scripts.

```
$ make deploy
```

Used to configure all the different services of the server

A couple of environment variables can be provided to change the settings of the task, like:

* TAGS: defines which services should be installed
* PLAYBOOK: defines which playbook to run
* LETSENCRYPT_FORCE_CERTIFICATES: defines if the Let's Encrypt certificates should be generated again
* ANSIBLE_OPTS: specify any other extra options
* ROOT: only for `make setup`, changes the port to be connected to (connects to port 22)


## Email

Go to whatever is your DNS and create the following records:

```
Type: MX - Mail Exchange
TTL: 1d
Value: 10 mail.{{ server }}
```

```
Type: Text
TTL: 1d
Name: mail._domainkey
Value: cat {{ email_opendkim_config_directory }}/mail.txt # copy what's within quotes (including quotes)
```

```
Type: SPF
TTL: 1d
Value: v=spf1 mx a ?all
```

Also contact your host provider about setting a PTR record.
