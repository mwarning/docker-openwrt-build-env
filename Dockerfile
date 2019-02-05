FROM alpine:edge

RUN apk add git build-base bash ncurses-dev perl tar findutils patch coreutils gawk grep unzip bzip2 wget python2-dev linux-headers curl diffutils bsd-compat-headers less diffutils zlib-dev && \
    addgroup -S user && \
    adduser -D -G user user

USER user
WORKDIR /home/user/build

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"
