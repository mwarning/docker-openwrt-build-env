FROM debian:jessie

RUN apt-get update &&\
    apt-get install -y time git-core subversion build-essential g++ bash make libssl-dev patch && \
    apt-get install -y libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python && \
    apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user && \
    mkdir /home/user/build

USER user
WORKDIR /home/user/build
