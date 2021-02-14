#!/bin/sh

su user
wget https://www.whonix.org/patrick.asc -O ~/patrick.asc
gpg --import ~/patrick.asc
gpg --keyid-format long --import --import-options show-only --with-fingerprint ~/patrick.asc
git clone --depth=1 --branch 15.0.1.6.4-developers-only --jobs=4 --recurse-submodules --shallow-submodules https://gitlab.com/whonix/Whonix.git ~/Whonix
cd ~/Whonix && git fetch
git verify-tag 15.0.1.6.4-developers-only
git checkout --recurse-submodules 15.0.1.6.4-developers-only
exit
cd /home/user/Whonix
sudo /home/user/Whonix/whonix_build --flavor whonix-gateway-cli --target root --build'
