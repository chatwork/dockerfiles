# scala
https://docs.scala-lang.org/

# sbt
https://www.scala-sbt.org/1.x/docs/index.html

## Usage
```
docker run --rm -it chatwork/scala-sbt:x86_64-ubuntu-jdk8u181-b13-2.12.4-1.1.0 /bin/bash
```

## cacertsに証明書を追加する
```
keytool -import -trustcacerts -file /path/to/xxxx.crt -keystore /path/to/cacerts -alias xxxx -storepass changeit
```
keytoolの詳しい説明は下記ページを参照
https://docs.oracle.com/javase/jp/8/docs/technotes/tools/unix/keytool.html#CHDBGFHE
