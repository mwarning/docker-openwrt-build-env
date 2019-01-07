# Docker OpenWrt Builder

Build OpenWrt images in a Docker container when building OpenWrt on the host systems fails.

## Prerequisites

* install Docker
* running Docker daemon
* build Docker image:

```
git clone https://github.com/mwarning/docker-openwrt-builder.git
cd docker-openwrt-builder
docker build -t openwrt_builder .
```

## Use

Create build folder and link it into a new docker container:
```
mkdir ~/mybuild
docker run -v ~/mybuild:/home/user/build -it openwrt_builder /bin/bash
```

In the container console, enter:
```
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make -j4
```

After the build, the images will be inside `~/mybuild/bin/target/`.

## Other Projects

Other, but very similar projects:
* [docker-openwrt](https://github.com/EasyPi/docker-openwrt)
* [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)
