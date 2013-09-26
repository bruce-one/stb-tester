#!/bin/bash

# Automated provisioning script run as the `vagrant` user by `vagrant up`
# -- see `./Vagrantfile` and `./setup.sh`.

set -e

stbt_version=0.15

# Install stbt to ~/bin
tmpdir=$(mktemp -d)
trap 'rm -rf $tmpdir' EXIT
git clone ~/stb-tester $tmpdir
cd $tmpdir
git checkout $stbt_version
make prefix=$HOME install

# Bash tab-completion
cat > ~/.bash_completion <<-'EOF'
	for f in ~/etc/bash_completion.d/*; do source $f; done
	EOF
mkdir -p ~/etc/bash_completion.d
wget -q -O ~/etc/bash_completion.d/gstreamer-completion-0.10 \
  https://raw.github.com/drothlis/gstreamer/bash-completion-0.10/tools/gstreamer-completion-0.10

sed -i '/### stb-tester configuration ###/,$ d' ~/.bashrc

mkdir -p ~/.config/stbt
cat > ~/.config/stbt/stbt.conf <<-EOF
	[global]
	source_pipeline = decklinksrc mode=2 connection=3
	
	# Handle loss of video (but without end-of-stream event) from the video
	# capture device. Set to "True" if you're using the Hauppauge HD PVR.
	#restart_source = False
	
	sink_pipeline = fakesink
	control = lirc::TRemote
	
	[run]
	save_video = /mnt/video.webm
	EOF
