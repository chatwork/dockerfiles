FROM adoptopenjdk/openjdk11:jdk-11.0.7_10

SHELL ["/bin/bash", "-c"]

ENV PATH=$PATH:/root/.sdkman/candidates/sbt/current/bin:/opt/java/openjdk/bin

RUN apt update && \
  apt-get install unzip && \
  apt-get install zip && \
  curl -s https://get.sdkman.io | bash && \
  source /root/.sdkman/bin/sdkman-init.sh && \
  sdk install sbt 1.3.10 && \
  sbt version

WORKDIR /tmp
