FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y \
    curl \
    wget \
    dumb-init \
    htop \
    locales \
    man \
    nano \
    git \
    procps \
    ssh \
    sudo \
    vim \
    openssl \
    zip \
    unzip \
    iputils-ping

RUN apt install -y \
	python3-pip \
	build-essential \
	libssl-dev \
	python3-dev \
	libgconf-2-4 \
	libstdc++6 python3-setuptools \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8

RUN chsh -s /bin/bash
ENV SHELL=/bin/bash

RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

RUN mkdir -p /home/coder/

RUN pip3 install jupyterlab
RUN pip3 install -U pip
RUN pip3 install -U turicreate

EXPOSE 8888

USER coder
WORKDIR /home/coder

VOLUME ["/home/coder"]

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
