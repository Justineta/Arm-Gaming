#!/bin/bash
### Personal public script ###
## Not in a final stage, be inspired but don't use it raw
## Gaming with Armbian
## @Justineta 

## https://www.datacamp.com/tutorial/how-to-write-bash-script-tutorial
echo "Warning this script is incomplete and only tested with Armbian for the moment !!!"
echo "Press Enter to try it anyway"
read
function MainMenu {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Main menu"
  MENU="Choose one of the following options:"
  echo "This program is designed to work in an Ubuntu based distro."
  OPTIONS=(
    1 "1. [RECOMMENDED]Do the basics (update, install few package, add ARM 32 bits, installing some gaming libs)."
    2 "2. Tools to improve compatibility of the games (OpenGL force version...)."
    3 "3. Install native games."
    4 "4. Install emulators."
    5 "5. Tools for x86, amd64 and Window\$ games."
    6 "6. General Tools like FPS counter. "
    7 "7. Benchmarking tools."
    8 "8. Greetings."
    9 "9. Time to eat." 
    )
  
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)
  
  clear
  case $CHOICE in
  1)
    DoTheBasics
    ;;
  2)
    MenuTools
    ;;
  3)
    MenuNativeGames
    ;;
  4)
    MenuEmulators
    ;;
  5)
    MenuBoxWine
    ;;
  6)
    MenuPracticalTools
    ;;
  7)
    MenuBenchmark
    ;;
  8)
    Greetings
    ;;
  9)
    echo "A plus et bon appétit ! "
	  exit
    ;;
          
  esac
}


function DoTheBasics {
	echo "Installing things like build-essential, git, curl, and some gaming libs for arm 32 bits and 64 bits"
	sudo dpkg --add-architecture armhf
 	sudo apt update
 	sudo apt install build-essential git curl
	sudo apt install cmake cabextract 7zip libncurses6:armhf libc6:armhf libx11-6:armhf libgdk-pixbuf2.0-0:armhf \
  		libgtk2.0-0:armhf libstdc++6:armhf libsdl2-2.0-0:armhf mesa-va-drivers:armhf libsdl-mixer1.2:armhf \
  		libpng16-16:armhf libsdl2-net-2.0-0:armhf libopenal1:armhf libsdl2-image-2.0-0:armhf libjpeg62:armhf \
  		libudev1:armhf libgl1-mesa-dev:armhf libx11-dev:armhf libsdl2-image-2.0-0:armhf libsdl2-mixer-2.0-0:armhf
	echo "build-essential git curl and other libs for gaming successfully installed, bravo"
	while true; do
    	read -p "Do you want to do a general update and reboot ? (y/n) " yn
    	case $yn in
          [Yy]* ) sudo apt dist-upgrade; 
          	echo "Please do a manual reboot now"; break;;
          [Nn]* ) MainMenu;;
          * ) echo "Please answer yes or no.";;
    esac
  done
}

function MenuTools {
  echo "Not implemented yet"
  echo "Press any key"
  read
  MainMenu
}

function MenuNativeGames {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Native game"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Open Arena, a quake based fast FPS"
    2 "2. Xmoto, a 2D moto challenging game"
    3 "3. Super Tux Kart, an arcade 3D racing game"
    4 "4. Super Tux, a story plateformer"
    5 "5. 0 A.D. - Empires Ascendant, a historical strategy game"
    6 "6. Return to the main menu"
  	)
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)
  
  clear
  case $CHOICE in
  1)
    sudo apt install openarena openarena-oacmp1; 
    echo "";
    echo "Type \"openarena\" in a terminal to play it";
    echo "Type \"sudo apt autoremove openarena openarena-oacmp1\" to remove the game";
    echo "Press any key";
    read;
    MenuNativeGames;;
  2)
    sudo apt install xmoto; 
    echo "";
    echo "Type \"xmoto\" in a terminal to play it";
    echo "Type \"sudo apt autoremove xmoto\" to remove the game";
    echo "Press any key";
    read;
    MenuNativeGames;;
  3)
    sudo apt install supertuxkart; 
    echo "";
    echo "Type \"supertuxkart\" in a terminal to play it";
    echo "Type \"sudo apt autoremove supertuxkart\" to remove the game";
    echo "Press any key";
    read;
    MenuNativeGames;;
  4)
    sudo apt install supertux;
    echo "";
    echo "Type \"supertux\" in a terminal to play it";
    echo "Type \"sudo apt autoremove supertux\" to remove the game";
    echo "Press any key";
    read;
    MenuNativeGames;;
  5)
    sudo apt install 0ad;
    echo "";
    echo "Type \"0ad\" in a terminal to play it";
    echo "Type \"sudo apt autoremove 0ad\" to remove the game";
    echo "Press any key";
    read;
    MenuNativeGames;;
  6)
    MainMenu
    ;;
          
  esac
  MainMenu
}

function MenuEmulators {
  echo "Not implemented yet"
  echo "Press any key"
  read
  MainMenu
}

function MenuBoxWine {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="x86, AMD64 and windows compatibility"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Install Box86"
    2 "2. Install Box64"
    3 "3. Install Wine"
    4 "4. Install Winetricks"
    5 "5. Install DXVK"
    6 "6. Return to the main menu"
	)
  
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)
  
  clear
  case $CHOICE in
  1)
    InstallBox86;
    echo "Press any key";
    read;;
  2)
    InstallBox64;
    echo "Press any key";
    read;;
  3)    
    InstallWine;
    echo "Press any key";
    read;;
  4)
    InstallWinetricks;
    echo "Press any key";
    read;;
  5)
    InstallDXVK;
    echo "Press any key";
    read;;
  6)
    MainMenu
    ;;
          
  esac
  MainMenu
}

function MenuPracticalTools {
  echo "Not implemented yet"
  echo "Press any key"
  read
  MainMenu
}

function MenuBenchmark {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Benchmark"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Install native benckmarking tool"
    2 "2. 	Benchmark CPU monothread"
    3 "3.	Benchmark CPU multithread"
    4 "4. 	Benchmark RAM"
    5 "5. 	Benchmark I/O"
    6 "6. Return to the main menu"
	)
  
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)
  
  clear
  case $CHOICE in
  1)
    sudo apt install sysbench;
    MenuBenchmark;;
  2)
    sysbench --test=cpu run;
    echo "Press any key";
    read;
    MenuBenchmark;;
  3)    
    Logical_Core_Number=$(nproc --all);
    sysbench --test=cpu --num-threads=$Logical_Core_Number run;
    echo "Press any key";
    read;
    MenuBenchmark;;
  4)
    sysbench --test=memory run;
    echo "Press any key";
    read;
    MenuBenchmark;;
  5)
    sysbench --test=fileio --file-test-mode=seqwr run;
    sysbench --test=fileio --file-test-mode=seqwr cleanup;
    echo "Press any key";
    read;
    MenuBenchmark;;
  6)
    MainMenu
    ;;
          
  esac
  MainMenu
}

function Greetings {
  echo "This script is based on some good scripts and videos : "
  echo "Videos of NicoD and Microlinux on Youtube "
  echo "Microlinux writed tutorial : https://github.com/neofeo/BOX86-BOX64-WINEx86-TUTORIAL "
  echo "NicoD script : https://github.com/NicoD-SBC/armbian-gaming/ "
  echo "The guide of Raezroth : https://github.com/Raezroth/Linux-ARM-Gaming-Chroot/ "
  echo "The work of PtitSeb : https://github.com/ptitSeb/ "
  echo "The work of Ryan Fortner : https://ryanfortner.github.io/ "
  echo "And the work of so many Gnu, Linux, Wine, Mesa... contributors of the FOSS project "
  read
  MainMenu
}

function InstallBox86 {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Box86"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Install Box86 from distro repo (easy way)"
    2 "2. Install Box86 from Ryan Fortner repo (generic recent packages)"
    3 "3. Remove a Box86 installed with distro or Ryan Fortner repo"
    4 "4. Install Box86 from source (compilation)"
    5 "5. Remove a Box86 version installed from de source"
    6 "6. Return to the Box/Wine menu menu"
	)
  
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)
  clear
  case $CHOICE in
  1)
    echo "If you have a Rockship RK3588 or RK3588S, it could not work, it is advised to build it from source";
	while true; do
    read -p "If you have a RK3588 or RK3588S, do you really want to try it ? (y/n) " yn;
	    case $yn in
	        [Yy]* ) dpkg --add-architecture armhf;
	 		sudo apt update;
	 		sudo apt install box86;
		 	echo "Press any key";
	 		read;
	 		InstallBox86;;
	        [Nn]* ) InstallBox86;;
	        * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press any key";
    read;
    InstallBox86;;
  2)
	echo "If you have a Rockship RK3588 or RK3588S, it could not work, it is advised to build it from source";
	while true; do
		read -p "If you have a RK3588 or RK3588S, do you really want to try it ? (y/n) " yn;
	   	case $yn in
		  [Yy]* ) 
		 	dpkg --add-architecture armhf;
			## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL for the base script
			echo "Installing things like build-essential and git from repo";
			sudo apt update && sudo apt install build-essential git curl;
			## Adding Box86 repo with command from Ryan Fortner repo because I have issue with microlinux command (https://box86.debian.ryanfortner.dev/) 
			sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list;
			wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg;
			sudo apt update && sudo apt install box86 -y;
	 		echo "Press any key";
	 		read;
	 		InstallBox86;;
		  [Nn]* ) InstallBox86;;
		  * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press any key";
    	read;
    	InstallBox86;;
  3)    
	sudo apt autoremove box86
	echo "Press any key";
    	read;
    	InstallBox86;;
  4)
    echo "Not implemented yet, see : https://github.com/ptitSeb/box86/blob/master/docs/COMPILE.md for more info";
    echo "Press any key";
    read;
    InstallBox86;;
  5)
    echo "Not implemented yet";
    echo "Press any key";
    read;
    InstallBox86;;
    ;;
  6)
    MenuBoxWine
    ;;
          
  esac
  MenuBoxWine
 }

function InstallBox64 {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Box64"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Install Box64 from distro repo (easy way)"
    2 "2. Install Box64 from Ryan Fortner repo (generic recent packages)"
    3 "3. Remove a Box64 installed with distro or Ryan Fortner repo"
    4 "4. Install Box64 from source (compilation)"
    5 "5. Remove a Box64 version installed from de source"
    6 "6. Return to the Box/Wine menu menu"
	)
  
  CHOICE=$(dialog --clear \
                  --backtitle "$BACKTITLE" \
                  --title "$TITLE" \
                  --menu "$MENU" \
                  $HEIGHT $WIDTH $CHOICE_HEIGHT \
                  "${OPTIONS[@]}" \
                  2>&1 >/dev/tty)
  clear
  case $CHOICE in
  1)
    echo "If you have a Rockship RK3588 or RK3588S, it could not work, it is advised to build it from source";
	while true; do
    read -p "If you have a RK3588 or RK3588S, do you really want to try it ? (y/n) " yn;
	    case $yn in
	        [Yy]* ) sudo apt update;
	 		sudo apt install box64;
		 	echo "Press any key";
	 		read;
	 		InstallBox64;;
	        [Nn]* ) InstallBox64;;
	        * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press any key";
    read;
    InstallBox64;;
  2)
	echo "If you have a Rockship RK3588 or RK3588S, it could not work, it is advised to build it from source";
	while true; do
		read -p "If you have a RK3588 or RK3588S, do you really want to try it ? (y/n) " yn;
	   	case $yn in
		  [Yy]* ) 
		 	## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL for the base script
			echo "Installing things like build-essential and git from repo";
			sudo apt update && sudo apt install build-essential git curl;
			## Adding Box86 repo with command from Ryan Fortner repo because I have issue with microlinux command (https://github.com/ryanfortner/box64-debs) 
			sudo wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list;
			wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg;
			sudo apt update && sudo apt install box64 -y;
	 		echo "Press any key";
	 		read;
	 		InstallBox64;;
		  [Nn]* ) InstallBox64;;
		  * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press any key";
    	read;
    	InstallBox64;;
  3)    
	sudo apt autoremove box64
	echo "Press any key";
    	read;
    	InstallBox64;;
  4)
    echo "Not implemented yet, see : https://github.com/ptitSeb/box86/blob/master/docs/COMPILE.md for more info";
    echo "Press any key";
    read;
    InstallBox64;;
  5)
    echo "Not implemented yet";
    echo "Press any key";
    read;
    InstallBox64;;
    ;;
  6)
    MenuBoxWine
    ;;
          
  esac
  MenuBoxWine
}

function InstallWine {
  echo "In the future"
  echo "Press any key"
  read
  MainMenu
}

function InstallWinetricks {
  echo "In the future"
  echo "Press any key"
  read
  MainMenu
}

function InstallDXVK {
  echo "In the future"
  echo "Press any key"
  read
  MainMenu
}

MainMenu
exit
echo "Don't show me this text"

## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL for the base script
echo "Installing things like build-essential and git from repo"
sudo apt update && sudo apt install build-essential git curl libxpresent1

## libxpresent1 seems to be needed on my side for winetricks to work

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
sudo apt install libxpresent1
cd wine && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && cd
chmod +x ~/wine/winetricks
sudo ln -s ~/wine/winetricks /usr/local/bin/
echo "Configuring Winetricks... (it make some times)"
W_OPT_UNATTENDED=1 winetricks mfc42 vcrun6 vcrun2003 xact d3drm d3dx9_43 d3dcompiler_43 \
  d3dx9 fontfix gdiplus dotnet20 msxml3 vcrun2005sp1 vcrun2008 fontsmooth=rgb

## DXVK part : not for the moment, work to do with mesa panvk
#winetricks dxvk

echo "Adding and updating to the last mesa drivers (and Gallium Nine for native DirectX 9 support)"
## Adding a PPA with the lastest mesa drivers
sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt update
sudo apt upgrade

# Some other choise who can be implemented later
#    Decide to not use oibaf (i.e. keep the MESA drivers that originally shipped with your system); or
#    Add the oibaf PPA and then install a different Linux kernel whose version works with the drivers installed by such PPA. Canonical provides hundreds of alternative kernels 8 that you can download and install, if you want to try them and know how to do it; or
#    Add a different PPA that also upgrades MESA, like e.g. kisak-mesa 23 or kisak-mesa-stable 23: the first one (kisak-mesa) provides mainline (i.e. more up-to-date but less compatible) MESA drivers, the second one (kisak-mesa-stable) provides MESA drivers that are likely older and less efficient but more stable and compatible than those provided by kisak-mesa.

echo "Installing Gallium Nine"
sudo apt install libd3dadapter9-mesa:armhf
winetricks galliumnine
wine ninewinecfg

##To use NINE on DX8 games: we drag an x86 .dll copy of the dx8 to dx9 wrapper from here https://github.com/crosire/d3d8to9/releases, we place it on the game folder, probably overriting the original lib (you can jsut rename the original first) and from terminal we execute the game with:
#WINEDLLOVERRIDES=d3d8.dll=n wine thedx8game.exe
##or you can just set `d3d8.dll` as native on winecfg but I think it's best the other way.
##on every ocassion, both dx9 or dx8 games with the wrapper, and if running from terminal, you will see gallium nine being used, if not, gallium nine isnt working for some reason and it's utilizing WINE3D.
##Note: For STEAM WINDOWS GAMES I recommend the usage of Goldeberg emulator, and it works the same way as on linux games, you just need to use the goldberg windows x86 libs to replace the game folder steam libraries to emulate steam. This isn't illegal at all!

## FPS counter
## https://linuxhint.com/show_fps_counter_linux_games/
sudo apt install xosd-bin mesa-utils mangohud
## mangohud last verstion here https://github.com/flightlessmango/MangoHud/releases
## Gamescope last version here https://github.com/Plagman/gamescope
## Gamescope seems to not get intregrated in the repo so compile it
sudo pat install meson
