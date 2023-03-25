#!/bin/bash
### Personal public script ###
## Gaming with Armbian
## @Justineta 

## https://www.datacamp.com/tutorial/how-to-write-bash-script-tutorial
echo "This script is following the guide of Microlinux and adding my own things (@Justineta on Github)"
## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL for the base script
echo "Installing things like build-essential and git from repo"
sudo apt update && sudo apt install build-essential git curl

echo "Installing Box86 and Box64 with Ryan Fortner repo"
## Adding Box86 and Box64 repo with command from Ryan Fortner repo because I have issue with microlinux command (https://box86.debian.ryanfortner.dev/) 
sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list
wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpghttps://box86.debian.ryanfortner.dev/
sudo apt update && sudo apt install box86 -y

## And box64 (https://github.com/ryanfortner/box64-debs)
sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list
wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg
sudo apt update && sudo apt install box64 -y

## And box86:armhf (https://box86.debian.ryanfortner.dev/)(not needed)
#sudo dpkg --add-architecture armhf
#sudo apt-get update
# proceed to add the repo using instructions above
#sudo apt-get install box86-rpi4arm64:armhf

echo "Allowing Panfrost to use OpenGL 3.3 (a beta and partial support who generally do the job)"
## Add env variable to force OpenGL 3.x
sudo bash -c "echo 'PAN_MESA_DEBUG=gl3' >> /etc/environment"

echo "Adding multiarch support"
## Adding armhf support with multiarch
sudo dpkg --add-architecture armhf
sudo apt update

echo "Installing Wine with Kron4ek precompiled amd64 version"
## Installing Wine x86_64
## https://github.com/Kron4ek/Wine-Builds for the tutorial
## https://github.com/Kron4ek/Wine-Builds/releases for the repo of stable and staging
## https://mega.nz/folder/ZZUV1K7J#kIenmTQoi0if-SAcMSuAHA for the repo of wine patched with proton

read -p "Where I am supposed to download Wine [wine-8.4-staging-tkg-amd64.tar.xz]: " winelink 
winelink=${winelink:-"https://github.com/Kron4ek/Wine-Builds/releases/download/8.4/wine-8.4-staging-tkg-amd64.tar.xz"}
cd && wget $winelink -O "wine.tar.xz"
mkdir wine
tar -xvf wine.tar.xz -C wine --strip-components 1
touch ./wine/downloaded-link.txt
echo $winelink >> ./wine/downloaded-link.txt

echo "Make symlink for wine"
## Symlink for wine
sudo ln -s ~/wine/bin/wine /usr/local/bin/
sudo ln -s ~/wine/bin/winecfg /usr/local/bin/
sudo ln -s ~/wine/bin/wineserver /usr/local/bin/
sudo ln -s ~/wine/bin/wine64 /usr/local/bin/

echo "Configure Wine, install mono and all the things the soft ask and put it in xp compatibility for the Windows version."
read -p "press any key if you read the text above "
winecfg

echo "Installing a bunch of libs for gaming (arm64 and armhf)"
## Interesting libs for gaming
sudo apt install cmake cabextract 7zip libncurses6:armhf libc6:armhf libx11-6:armhf libgdk-pixbuf2.0-0:armhf \
  libgtk2.0-0:armhf libstdc++6:armhf libsdl2-2.0-0:armhf mesa-va-drivers:armhf libsdl-mixer1.2:armhf \
  libpng16-16:armhf libsdl2-net-2.0-0:armhf libopenal1:armhf libsdl2-image-2.0-0:armhf libjpeg62:armhf \
  libudev1:armhf libgl1-mesa-dev:armhf libx11-dev:armhf libsdl2-image-2.0-0:armhf libsdl2-mixer-2.0-0:armhf

echo "Installing Winetricks"
## Installing Winetricks https://github.com/Winetricks/winetricks
cd wine && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && cd
chmod +x ~/wine/winetricks
sudo ln -s ~/wine/winetricks /usr/local/bin/
echo "Configuring Winetricks... (it make some times)"
W_OPT_UNATTENDED=1 winetricks mfc42 vcrun6 vcrun2003 xact d3drm d3dx9_43 d3dcompiler_43 \
  d3dx9 fontfix gdiplus dotnet20 msxml3 vcrun2005sp1 vcrun2008 fontsmooth=rgb
  
  
