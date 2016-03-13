FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

# Set locale
ENV LANG C.UTF-8
ENV LANGUAGE C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y locales -qq && \
    locale-gen en_US.UTF-8 en_us && \
    dpkg-reconfigure locales && \
    dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

# Add some basic dependencies
RUN apt-get install -y build-essential apt-transport-https postgresql-client \
    sudo openssh-client git unzip wget curl libexpat1 libexpat1-dev \
    ruby bundler netcat lsof strace net-tools python-pip

# Install Packagecloud Deps Repo
COPY packagecloud.sh /root/
RUN /root/packagecloud.sh && apt-get update -qq && rm -f /root/packagecloud.sh

# Install Operable Deps
RUN apt-get install -qq -y erlang=18.2.2 elixir=1.2 libsodium=1.0.8 goon=1.1.1

# Setup Operable User and App Dir
RUN mkdir -p /app
RUN useradd -m -d /home/operable -s /bin/bash -c 'Operable Admin User' operable
RUN chown -R operable:operable /home/operable /app

WORKDIR /home/operable
RUN mkdir /home/operable/bin
USER operable

# Install local hex and rebar
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force
