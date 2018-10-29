# openjdk8

https://openjdk.java.net/
https://adoptopenjdk.net/


## Usage

```
docker run --rm -it chatwork/openjdk8:x86_64-alpine-jdk8u181-b13 /bin/sh
```

## cacertsに証明書を追加する
```
keytool -import -trustcacerts -file /path/to/xxxx.crt -keystore /path/to/cacerts -alias xxxx -storepass changeit
```
keytoolの詳しい説明は下記ページを参照
https://docs.oracle.com/javase/jp/8/docs/technotes/tools/unix/keytool.html#CHDBGFHE