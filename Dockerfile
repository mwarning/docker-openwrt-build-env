FROM debian:buster

RUN apt-get update &&\
    apt-get install -y \
        sudo build-essential ccache ecj fastjar file g++ gawk \
        gettext git java-propose-classpath libelf-dev libncurses5-dev \
        libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
        python3-distutils python3-setuptools python3-dev rsync subversion \
        swig time xsltproc zlib1g-dev && \
    apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"
