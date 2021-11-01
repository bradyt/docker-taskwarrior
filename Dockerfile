FROM debian:sid

RUN apt-get update && apt-get install -y \
    asciinema \
    cmake \
    curl \
    entr \
    faketime \
    g++ \
    gnutls-bin \
    libgnutls28-dev \
    systemctl \
    tmux \
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

ADD /root /root
ENV TASKDDATA /root/opt/var/taskd

WORKDIR /root

RUN task add foo\\

RUN taskdctl start && sleep 3 && task sync

RUN rm ~/.task/*.data

RUN taskdctl start && sleep 3 && task sync
