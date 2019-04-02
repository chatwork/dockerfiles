# MailCatcher docker image

https://mailcatcher.me/

## Usage

```
$ docker run -it --rm -p 1080:1080 -p 1025:1025 --name mailcatcher chatwork/mailcatcher
Starting MailCatcher
==> smtp://0.0.0.0:1025
/usr/local/bundle/gems/thin-1.5.1/lib/thin/server.rb:104: warning: constant ::Fixnum is deprecated
==> http://0.0.0.0:1080/
```

Send email to mailcatcher

```
$ curl telnet://localhost:1025
220 EventMachine SMTP Server
helo a
250 Ok EventMachine SMTP Server
mail from:<from@example.com>
250 Ok
rcpt to:<to@example.com>
250 Ok
data
354 Send it
Subject: Hello

Body
.
250 Message accepted
^C
```

Web interface

```
$ open http://localhost:1080/
```

Web API

```
$ curl http://localhost:1080/messages | jq .
  [
    {
      "id": 1,
      "sender": "<from@example.com>",
      "recipients": [
        "<to@example.com>"
      ],
      "subject": "Hello",
      "size": "24",
      "created_at": "2019-04-02T07:20:44+00:00"
    }
  ]
```
