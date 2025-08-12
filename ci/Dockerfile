FROM ubuntu:24.04

ARG UBUNTU_MIRROR="https://ftp.gwdg.de/pub/linux/debian/ubuntu/"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get reinstall ca-certificates -y
RUN sed -i "s,http://archive.ubuntu.com/ubuntu/,$UBUNTU_MIRROR," /etc/apt/sources.list \
 && sed -i "s,http://security.ubuntu.com/ubuntu/,$UBUNTU_MIRROR," /etc/apt/sources.list \
 && cat /etc/apt/sources.list

RUN apt-get update \
 && apt-get install -y \
    binutils-dev \
    build-essential \
    clang-format \
    clang-tidy \
    cmake \
    curl \
    debhelper \
    gdb \
    git \
    git-buildpackage \
    libgtest-dev \
    libyaml-cpp-dev \
    locales \
    pkg-config \
    software-properties-common \
    sudo \
    wget

RUN add-apt-repository ppa:elos-team/ppa
RUN apt-get update \
 && apt-get install -y \
    elos-plugin-backend-fetchapi \
    elos-plugin-client-tcp \
    elosc \
    elosd \
    libelos-dev \
    libelosplugin-dev \
    libelosplugin1 \
    libsafu-dev \
    libsamconf-dev \
    samconf-tools \
 && rm -rf /var/lib/apt/lists/*
    # libsafu0 \
    # libsamconf0 \

ARG USER=ci
ARG UID=1000
ARG GID=1000
RUN locale-gen en_US.UTF-8 \
 && locale-gen de_DE.UTF-8 \
 && userdel ubuntu \
 && groupadd -g $GID -o $USER \
 && useradd -m -u $UID -g $GID -s /bin/bash $USER \
 && echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
ENV LC_ALL=en_US.UTF-8
ENV DOCKERBUILD=1


WORKDIR /base

CMD /bin/bash

