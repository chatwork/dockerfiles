FROM alpine/git:v2.26.2 as git

ARG KUBE_SCHEDULE_SCALER_VERSION=0.0.1

WORKDIR /
RUN git clone https://github.com/chatwork/kube-schedule-scaler -b $KUBE_SCHEDULE_SCALER_VERSION /kube-schedule-scaler

FROM ubuntu:20.04

LABEL version="${KUBE_SCHEDULE_SCALER_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

MAINTAINER "sakamoto@chatwork.com"

# Install python tools and dev packages
RUN apt-get update \
    && apt-get install -q -y --no-install-recommends  python3-pip python3-setuptools python3-wheel gcc cron \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set python 3 as the default python version
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
RUN pip3 install --upgrade pip requests setuptools pipenv
RUN pip3 install pykube-ng==20.7.2  python-crontab==2.5.1 croniter==0.3.34

COPY --from=git /kube-schedule-scaler /chatwork/kube-schedule-scaler

RUN cp /chatwork/kube-schedule-scaler/run_missed_jobs.py /root \
    && cp /chatwork/kube-schedule-scaler/startup.sh /root \
    && cp -r /chatwork/kube-schedule-scaler/schedule_scaling /root \
    && chmod 500 /root/run_missed_jobs.py \
    && chmod 500 /root/startup.sh \
    && rm -rf /chatwork

CMD /root/startup.sh
