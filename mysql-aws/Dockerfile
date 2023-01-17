FROM mysql:5.7.41-debian

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y curl jq unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install