# ansible-server

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
