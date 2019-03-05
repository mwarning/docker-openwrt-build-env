FROM debian:jessie

RUN apt-get update &&\
    apt-get install -y sudo time git-core subversion build-essential g++ bash make libssl-dev patch && \
    apt-get install -y libncurses5-dev zlib1g-dev gawk flex gettext wget unzip python xz-utils && \
    apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"
