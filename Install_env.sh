### Personal public note ###
## Gaming with Armbian

## Following the guide of Microlinux and adding my own things
## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL

## Adding Box86 and Box64 repo with command from Ryan Fortner repo because I have issue with microlinux command (https://box86.debian.ryanfortner.dev/) 
sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpghttps://box86.debian.ryanfortner.dev/
sudo apt update && sudo apt install box86 -y

## And box64 (https://github.com/ryanfortner/box64-debs)
sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
sudo apt update && sudo apt install box86 -y

## And box86:armhf (https://box86.debian.ryanfortner.dev/)(not needed)
#sudo dpkg --add-architecture armhf
#sudo apt-get update
# proceed to add the repo using instructions above
#sudo apt-get install box86-rpi4arm64:armhf

## Add env variable to force OpenGL 3.x
sudo bash -c "echo 'PAN_MESA_DEBUG=gl3' >> /etc/environment"

## Adding armhf support with multiarch
sudo dpkg --add-architecture armhf
