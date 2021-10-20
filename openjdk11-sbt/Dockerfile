FROM adoptopenjdk/openjdk11:jdk-11.0.12_7

LABEL version="jdk-11.0.12_sbt-1.5.5"
LABEL maintainer="tsuru@chatwork.com"
LABEL maintainer="shimomura@chatwork.com"

SHELL ["/bin/bash", "-c"]

ENV PATH=$PATH:/root/.sdkman/candidates/sbt/current/bin:/opt/java/openjdk/bin

RUN apt update && \
  apt-get install unzip && \
  apt-get install zip && \
  curl -s https://get.sdkman.io | bash && \
  source /root/.sdkman/bin/sdkman-init.sh && \
  sdk install sbt 1.5.5 &&  \
  cd /tmp/ && \
  sbt version

WORKDIR /tmp
