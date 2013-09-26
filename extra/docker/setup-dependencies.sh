#!/bin/bash

# Automated provisioning script run as the `root` user by `vagrant up`
# -- see `./Vagrantfile`.

set -e

cat /proc/mounts > /etc/mtab

install_packages() {
  local packages
  # X11 environment so that you can use `ximagesink`
  packages="xorg xauth"
  # Core stbt dependencies
  packages+=" gstreamer0.10 python-gst0.10 python-opencv python-numpy"
  # For `stbt power`
  packages+=" curl expect openssh-client"
  # For `extra/runner`
  packages+=" lsof moreutils python-flask python-jinja2"
  # For building stbt and running the self-tests
  packages+=" git pep8 pylint python-docutils python-nose"
  # For the Hauppauge HDPVR
  packages+=" gstreamer0.10-ffmpeg v4l-utils"

  apt-get install -y $packages
}

apt-get update

install_packages

DEBIAN_FRONTEND=noninteractive apt-get install -y lirc
#sed -i \
#    -e 's,^START_LIRCD="false",START_LIRCD="true",' \
#    -e 's,^REMOTE_DEVICE=".*",REMOTE_DEVICE="/dev/lirc0",' \
#    /etc/lirc/hardware.conf
#service lirc start
# You still need to install /etc/lirc/lircd.conf with a description of your
# remote control's infrared protocol. See http://stb-tester.com/lirc.html
