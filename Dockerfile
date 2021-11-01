FROM debian:sid

RUN apt-get update && apt-get install -y \
    asciinema \
    cmake \
    curl \
    faketime \
    g++ \
    gnutls-bin \
    libgnutls28-dev \
    uuid-dev \
    vim

RUN curl -O https://taskwarrior.org/download/task-2.6.1.tar.gz
RUN tar xzvf task-2.6.1.tar.gz
WORKDIR task-2.6.1
RUN cmake -DCMAKE_BUILD_TYPE=release .
RUN make
RUN make install
WORKDIR ..

RUN curl -O https://taskwarrior.org/download/taskd-1.1.0.tar.gz
RUN tar xzvf taskd-1.1.0.tar.gz
WORKDIR taskd-1.1.0
RUN cmake -DCMAKE_BUILD_TYPE=release .
RUN make
RUN make install
WORKDIR ..

RUN apt-get install systemctl

ADD /root /root
ENV TASKDDATA /root/opt/var/taskd

RUN taskd config request.limit 0

RUN cp /root/taskd.service /etc/systemd/system

WORKDIR /root

# RUN sh script.sh

# CMD systemctl start taskd.service && sleep 3 && task sync
