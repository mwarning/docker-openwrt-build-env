# Docker OpenWrt Build Environment

Build [OpenWrt](https://openwrt.org/) images in a Docker container. This is sometimes necessary when building OpenWrt on the host system fails, e.g. when some dependency is too new. The docker image is based on Debian 10 (Buster).

Build tested:

- Openwrt-23.05.0-rc1
- OpenWrt-22.03.5
- OpenWrt-21.02.2
- OpenWrt-19.07.8
- OpenWrt-18.06.9

A smaller container based on Alpine Linux is available in the alpine branch. But it does not build the old LEDE images.

## Prerequisites

* Docker installed
* running Docker daemon
* build Docker image:

```shell
git clone https://github.com/mwarning/docker-openwrt-builder.git
cd docker-openwrt-builder
docker build -t openwrt_builder .
```

Now the docker image is available. These steps only need to be done once.

## Usage GNU/Linux

Create a build folder and link it into a new docker container:
```shell
mkdir ~/mybuild
docker run -v ~/mybuild:/home/user -it openwrt_builder /bin/bash
```

In the container console, enter:
```shell
git clone https://git.openwrt.org/openwrt/openwrt.git
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make -j4
```

After the build, the images will be inside `~/mybuild/openwrt/bin/target/`.

## Usage MacOSX

OpenWrt requires a case-sensitive filesystem while MacOSX uses a case-insensitive filesystem by default.

Create a sparse disk image (to limit space usage):
```zsh
mkdir ~/Documents/openwrt
cd ~/Documents/openwrt
hdiutil create -size 64g -fs "Case-sensitive HFS+" -type SPARSEBUNDLE -volname openwrt-dev-env openwrt-dev-env.dmg 
hdiutil attach openwrt-dev-env.dmg
```

Then run:
```zsh
docker run -v /Volumes/openwrt-dev-env:/home/user -it openwrt_builder /bin/bash
```

Inside the container shell create a image file that will be formatted in ext4 then mounted (thanks to [HowellBP](https://github.com/HowellBP/ext4-on-macos-using-docker) for the inspiration):

```shell
cd /home/user # not really needed
dd if=/dev/zero of=ext4openwrtfs.img bs=1G count=0 seek=60 # set "seek=" to however many gigabytes you want, always less than the created dmg image
mkfs.ext4 ext4openwrtfs.img # create filesystem

mkdir ./openwrt-fs # create mount folder
losetup -fP --show ext4openwrtfs.img # this will return a /dev/loop ID, e.g. /dev/loop1, change line below with the correct one
sudo mount /dev/loop1 ./openwrt-fs # mount support folder
sudo chown -R user:user ./openwrt-fs # change ownership to user
cd ./openwrt-fs # $(pwd) should be /home/user/openwrt-fs
```

At this point you can proceed with the same commands of the Linux usage:

```shell
git clone https://git.openwrt.org/openwrt/openwrt.git # repo will be in /home/user/openwrt-fs/openwrt
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make -j4 # adapt to the number of cores you want to use 
```

After the build, the images will be inside `/home/user/openwrt-fs/openwrt/bin/target/` in the container, **inside the .img file**. To export them to your Mac you need to copy/move them in `/home/user` then you'll be able to access them from outside the container, in `/Volumes/openwrt-dev-env/`

([Source](https://openwrt.org/docs/guide-developer/easy.build.macosx))

## Usage Windows

TODO

## Other Projects

Other, but very similar projects:
* [docker-openwrt-buildroot](https://github.com/noonien/docker-openwrt-buildroot)
* [openwrt-docker-toolchain](https://github.com/mchsk/openwrt-docker-toolchain)

