#!/bin/bash
### Personal public script ###
## Not in a final stage, be inspired but don't use it raw
## Gaming with Armbian
## @Justineta 

cd ~/
echo "Warning this script is incomplete and only tested with Armbian at the moment !!!"
echo "Arm-Gaming version 0.2 by Justineta"
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
    echo "A plus et bon appétit ! ";
		exit;;
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
  		libudev1:armhf libgl1-mesa-dev:armhf libx11-dev:armhf libsdl2-image-2.0-0:armhf libsdl2-mixer-2.0-0:armhf \
		  libvulkan1 libvulkan1:armhf gcc-arm-linux-gnueabihf libc6-dev-armhf-cross ;
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
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Improving Tools"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Force OpenGL 3 support on Mali GPU"
    2 "2. Force OpenGL 3 support on Raspberry Pi GPU"
    3 "3. Use lastest Panfrost drivers (for Mali GPU only) with gallium nine support"
    4 "4. Remove lastest Panfrost driver to return to distrib provided package"
    5 "5. Add mesa Vulkan support (do step 3 before to have the lastest Panfrost drivers and try to use PanVK)"
    6 "6. Force PanVK usage in environnement variable"
    7 "7. Print driver info for OpenGL and Vulkan in a file"
    8 "8. Return to the main menu"
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
    echo "Allowing Panfrost to use OpenGL 3.3 (a beta and partial support who generally do the job)";
    sudo bash -c "echo 'PAN_MESA_DEBUG=gl3' >> /etc/environment"; 
    echo "Only do it ones, reboot if you want to use this tricks";
    echo "Press Enter";
    read;
    MenuTools;;
  2)
    sudo bash -c "echo 'MESA_GL_VERSION_OVERRIDE=3.3' >> /etc/environment";
    sudo bash -c "echo 'MESA_GLSL_VERSION_OVERRIDE=330' >> /etc/environment"; 
    echo "Only do it ones, reboot if you want to use this tricks";    
    echo "Press Enter";
    read;
    MenuTools;;
  3)
    echo "Adding and updating to the last mesa drivers (and Gallium Nine for native DirectX 9 support)";
    ## Adding a PPA with the lastest mesa drivers
    ## https://www.phoronix.com/forums/forum/linux-graphics-x-org-drivers/opengl-vulkan-mesa-gallium3d/24959-updated-and-optimized-ubuntu-free-graphics-drivers?50038-Updated-and-Optimized-Ubuntu-Free-Graphics-Drivers=
    ## https://wiki.ixit.cz/d3d9
    ## https://launchpad.net/~oibaf/+archive/ubuntu/graphics-drivers
    sudo add-apt-repository ppa:oibaf/graphics-drivers;
    sudo apt update;
    sudo apt full-upgrade;
    echo "Press Enter";
    read;
    MenuTools;;
  4)
    echo "Removing lastest mesa drivers to return to distrubution provided graphic driver";
    ## Adding a PPA with the lastest mesa drivers
    sudo ppa-purge ppa:oibaf/graphics-drivers;
    sudo ppa-purge ppa:oibaf/graphics-drivers;
    sudo apt update;
    sudo apt full-upgrade;
    echo "Press Enter";
    read;
    MenuTools;;
  5)
    echo "Adding Mesa Vulkan support (LLVMPIPE and PanVK)";
    sudo apt install libvulkan1 mesa-vulkan-drivers vulkan-tools;
    echo "You need to use \"PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1\" before a program or use the function to force it (Menu 5) if you want to use PanVK, otherwise LLVM pipe will be used";
    echo "Press Enter";
    read;
    MenuTools;;
  6)
    echo "Force the partial panVK implementation (not recommanded)";
    echo "Remove the line \"PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1\" from /etc/environment if you want to remove it later";
    sudo bash -c "echo 'PAN_I_WANT_A_BROKEN_VULKAN_DRIVER=1' >> /etc/environment"; 
    echo "Only do it ones, reboot if you want to use this tricks";
    echo "Press Enter";
    read;
    MenuTools;;
  7)
    sudo apt install mesa-utils vulkan-tools;
    echo "Print OpenGL info";
    glxinfo -B;
    glxinfo >> ~/glxinfo.txt;
    vulkaninfo >> ~/vulkaninfo.txt;
    echo "~/glxinfo.txt and ~/vulkaninfo.txt file created in the home folder";
    echo "Press Enter";
    read;
    MenuTools;;
  8)
    MainMenu;;
          
  esac
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
    1 "1. Flare, Diablo like RPG"
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
    sudo apt install flare; 
    echo "";
    echo "Type \"flare\" in a terminal to play it";
    echo "Type \"sudo apt autoremove flare\" to remove the game";
    echo "Press Enter";
    read;
    MenuNativeGames;;
  2)
    sudo apt install xmoto; 
    echo "";
    echo "Type \"xmoto\" in a terminal to play it";
    echo "Type \"sudo apt autoremove xmoto\" to remove the game";
    echo "Press Enter";
    read;
    MenuNativeGames;;
  3)
    sudo apt install supertuxkart; 
    echo "";
    echo "Type \"supertuxkart\" in a terminal to play it";
    echo "Type \"sudo apt autoremove supertuxkart\" to remove the game";
    echo "Press Enter";
    read;
    MenuNativeGames;;
  4)
    sudo apt install supertux;
    echo "";
    echo "Type \"supertux\" in a terminal to play it";
    echo "Type \"sudo apt autoremove supertux\" to remove the game";
    echo "Press Enter";
    read;
    MenuNativeGames;;
  5)
    sudo apt install 0ad;
    echo "";
    echo "Type \"0ad\" in a terminal to play it";
    echo "Type \"sudo apt autoremove 0ad\" to remove the game";
    echo "Press Enter";
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
  echo "Press Enter"
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
    echo "Press Enter";
    read;;
  2)
    InstallBox64;
    echo "Press Enter";
    read;;
  3)    
    InstallWine;
    echo "Press Enter";
    read;;
  4)
    InstallWinetricks;
    echo "Press Enter";
    read;;
  5)
    InstallDXVK;
    echo "Press Enter";
    read;;
  6)
    MainMenu
    ;;
          
  esac
  MainMenu
}

function MenuPracticalTools {
  echo "Not implemented yet"
  echo "Press Enter"
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
    6 "6. 	Install and launch GLmark2 (OpenGL 2 Benchmark)"
    7 "7. 	Install and launch HardInfo"
    8 "8. Return to the main menu"
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
    sysbench cpu run;
    echo "Press Enter";
    read;
    MenuBenchmark;;
  3)    
    Logical_Core_Number=$(nproc --all);
    sysbench cpu --threads=$Logical_Core_Number run;
    echo "Press Enter";
    read;
    MenuBenchmark;;
  4)
    sysbench memory run;
    echo "Press Enter";
    read;
    MenuBenchmark;;
  5)
    sysbench fileio --file-test-mode=seqwr run;
    sysbench fileio --file-test-mode=seqwr cleanup;
    echo "Press Enter";
    read;
    MenuBenchmark;;
  6)
    sudo apt install glmark2;
    glmark2;
    echo "Press Enter";
    read;
    MenuBenchmark;;
  7)
    sudo apt install hardinfo;
    hardinfo;
    echo "Press Enter";
    read;
    MenuBenchmark;;
  8)
    MainMenu;;
          
  esac
  MainMenu
}

## For the future add some benchmark.unigine.com 
## https://wiki.archlinux.org/title/benchmarking

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
    6 "6. Return to the Box/Wine menu"
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
	        [Yy]* ) sudo dpkg --add-architecture armhf;
	 		sudo apt update;
	 		sudo apt install box86;
		 	echo "Press Enter";
	 		read;
	 		InstallBox86;;
	        [Nn]* ) InstallBox86;;
	        * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press Enter";
    read;
    InstallBox86;;
  2)
	echo "If you have a Rockship RK3588 or RK3588S, it could not work, it is advised to build it from source";
	while true; do
		read -p "If you have a RK3588 or RK3588S, do you really want to try it ? (y/n) " yn;
	   	case $yn in
		  [Yy]* ) 
		 	sudo dpkg --add-architecture armhf;
			## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL for the base script
			echo "Installing things like build-essential and git from repo";
			sudo apt update && sudo apt install build-essential git curl;
			## Adding Box86 repo with command from Ryan Fortner repo because I have issue with microlinux command (https://box86.debian.ryanfortner.dev/) 
			sudo wget https://ryanfortner.github.io/box86-debs/box86.list -O /etc/apt/sources.list.d/box86.list;
			wget -qO- https://ryanfortner.github.io/box86-debs/KEY.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/box86-debs-archive-keyring.gpg;
			sudo apt update && sudo apt install box86-generic-arm;
	 		echo "Press Enter";
	 		read;
	 		InstallBox86;;
		  [Nn]* ) InstallBox86;;
		  * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press Enter";
    	read;
    	InstallBox86;;
  3)    
	sudo apt autoremove box86 box86-generic-arm
	echo "Press Enter";
    	read;
    	InstallBox86;;
  4)
    HEIGHT=15
    WIDTH=80
    CHOICE_HEIGHT=4
    BACKTITLE="Arm-Gaming"
    TITLE="Box86"
    MENU="Choose one of the following options:"
    OPTIONS=(
      1 "1. Compile for Pandora"
      2 "2. Compile for Pyra"
      3 "3. Compile for Gameshell"
      4 "4. Compile for Raspberry Pi 2 or 3"
      5 "5. Compile for Rapsberry Pi 4 32 bit OS (armhf)"
      6 "6. Compile for Raspberry Pi 4 64 bit OS (arm64"
      7 "7. Compile for ODROID N2 or N2+ or N2L (AmLogic S922X)"
      8 "8. Compile for another ODROID"
      9 "9. Compile for a Rockchip RK3399 or RK3399Pro"
      10 "10. Compile for a Rockchip RK3588 or RK3588S"
      11 "11. Compile for a Rockchip RK3288 (Tinker Borad 1/1S)"
      12 "12. Compile for a Snapdragon 845"
      13 "13. Compile for Allwinner A64"
      14 "14. Compile for Phytium (D2000 or FT2000/4)"
      15 "15 Compile for a generic ARM64 64 bit OS platform"
      16 "16. Compile for a generic ARM platform"
      17 "17. Return to the Box86 menu"
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
      COMPILATION_INSTRUCTION="-D PANDORA=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    2)
      COMPILATION_INSTRUCTION="-D PYRA=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    3)
      COMPILATION_INSTRUCTION="-D GAMESHELL=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    4)
      COMPILATION_INSTRUCTION="-D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    5)
      COMPILATION_INSTRUCTION="-D RPI4=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    6)
      COMPILATION_INSTRUCTION="-D RPI4ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    7)
      COMPILATION_INSTRUCTION="-D ODROIDN2=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    8)
      COMPILATION_INSTRUCTION="-D ODROID=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    9)
      COMPILATION_INSTRUCTION="-D RK3399=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    10)
      COMPILATION_INSTRUCTION="-D RK3588=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    11)
      COMPILATION_INSTRUCTION="-D RK3288=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    12)
      COMPILATION_INSTRUCTION="-D SD845=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    13)
      COMPILATION_INSTRUCTION="-D A64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    14)
      COMPILATION_INSTRUCTION="-D PHYTIUM=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    15)
      COMPILATION_INSTRUCTION="-D ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    16)
      COMPILATION_INSTRUCTION="-D ARM_DYNAREC=ON -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    17)
      InstallBox86;;
    esac;
    
    cd ~/ ;
    git clone https://github.com/ptitSeb/box86 \
    && cd box86 \
    && mkdir build \
    && cd build ;
    cmake .. $COMPILATION_INSTRUCTION \
    && make -j3 && echo "Compilation completed";
		sudo make install && sudo systemctl restart systemd-binfmt \
	  && echo "Installation completed";
    echo "Press Enter";
    read;
    InstallBox86;;
  5)
    cd ~/box86/build && sudo make uninstall && echo "Succefully removed";
    echo "Press Enter";
    read;
    InstallBox86;;
  6)
    MenuBoxWine;;
          
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
		 	echo "Press Enter";
	 		read;
	 		InstallBox64;;
	        [Nn]* ) InstallBox64;;
	        * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press Enter";
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
			sudo apt update && sudo apt install box64-arm64;
	 		echo "Press Enter";
	 		read;
	 		InstallBox64;;
		  [Nn]* ) InstallBox64;;
		  * ) echo "Please answer y or n.";;
	    esac;
    done;
	echo "Press Enter";
    	read;
    	InstallBox64;;
  3)    
	sudo apt autoremove box64 box64-arm64
	echo "Press Enter";
    	read;
    	InstallBox64;;
  4)
    HEIGHT=15
    WIDTH=80
    CHOICE_HEIGHT=4
    BACKTITLE="Arm-Gaming"
    TITLE="Box64"
    MENU="Choose one of the following options:"
    OPTIONS=(
      1 "1. Compile for Raspberry Pi 3"
      2 "2. Compile for Raspberry Pi 4 64 bit OS (arm64)"
      3 "3. Compile for ODROID N2 or N2+ or N2L (AmLogic S922X)"
      4 "4. Compile for a Rockchip RK3399 or RK3399Pro"
      5 "5. Compile for a Rockchip RK3588 or RK3588S"
      6 "6. Compile for a Nvidia Tegra X1"
      7 "7. Compile for a Snapdragon 845"
      8 "8. Compile for Phytium (D2000 or FT2000/4)"
      9 "9 Compile for a generic ARM64 64 bit OS platform"
      10 "10. Return to the Box86 menu"
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
      COMPILATION_INSTRUCTION="-D RPI3ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    2)
      COMPILATION_INSTRUCTION="-D RPI4ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    3)
      COMPILATION_INSTRUCTION="-D ODROIDN2=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    4)
      COMPILATION_INSTRUCTION="-D RK3399=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    5)
      COMPILATION_INSTRUCTION="-D RK3588=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    6)
      COMPILATION_INSTRUCTION="-D TEGRAX1=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    7)
      COMPILATION_INSTRUCTION="-D SD845=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    8)
      COMPILATION_INSTRUCTION="-D PHYTIUM=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    9)
      COMPILATION_INSTRUCTION="-D ARM64=1 -D CMAKE_BUILD_TYPE=RelWithDebInfo";;
    10)
      InstallBox86;;
    esac;
    
    cd ~/ ;
    git clone https://github.com/ptitSeb/box64 \
    && cd box64 \
    && mkdir build \
    && cd build ;
    cmake .. $COMPILATION_INSTRUCTION \
    && make -j3 && echo "Compilation completed";
		sudo make install && sudo systemctl restart systemd-binfmt \
	  && echo "Installation completed";
    echo "Press Enter";
    read;
    InstallBox64;;
  5)
    cd ~/box64/build && sudo make uninstall && echo "Succefully removed";
    echo "Press Enter";
    read;
    InstallBox64;;
  6)
    MenuBoxWine;;
          
  esac
  MenuBoxWine
}

function InstallWine {
  HEIGHT=15
  WIDTH=80
  CHOICE_HEIGHT=4
  BACKTITLE="Arm-Gaming"
  TITLE="Box64"
  MENU="Choose one of the following options:"
  OPTIONS=(
    1 "1. Install Wine 7.0 (stable) from x86 Kron4ek package"
    2 "2. Install Wine 8.0 (memory leak issue) from x86 Kron4ek package"
    3 "3. Remove Wine 7.0 or 8.0"
    4 "4. Install Wine from source (compilation)"
    5 "5. Remove a Wine version installed from de source"
    6 "6. Link wine to the system"
    7 "7. Return to the Box/Wine menu menu"
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
    wget -O ~/wine-7.0-x86.tar.xz https://github.com/Kron4ek/Wine-Builds/releases/download/7.0/wine-7.0-x86.tar.xz \
    && tar -xf ~/wine-7.0-x86.tar.xz -C ~/ \
    && mv ~/wine-7.0-x86 ~/wine \
    && rm ~/wine-7.0-x86.tar.xz \
    && echo "Installation completed for Wine 7.0";
    echo "Press Enter";
    read;
    InstallWine;;
  2)
    wget -O ~/wine-8.0-x86.tar.xz https://github.com/Kron4ek/Wine-Builds/releases/download/8.0/wine-8.0-x86.tar.xz \
    && tar -xf ~/wine-8.0-x86.tar.xz -C ~/ \
    && mv ~/wine-8.0-x86 ~/wine \
    && rm ~/wine-8.0-x86.tar.xz \
    && echo "Installation completed for Wine 8.0";
    echo "Press Enter";
    read;
    InstallWine;;
  3)    
    rm -r ~/wine \
    && echo "Installation removed";
    echo "Press Enter";
    read;
    InstallWine;;
  4)
    echo "Not implemented yet";
    echo "Press Enter";
    read;
    InstallWine;;
  5)
    echo "Not implemented yet";
    echo "Press Enter";
    read;
    InstallWine;;
  6)
    sudo ln -s ~/wine/bin/wine /usr/local/bin/ ;
    sudo ln -s ~/wine/bin/winecfg /usr/local/bin/ ;
    sudo ln -s ~/wine/bin/wineserver /usr/local/bin/ ;
    sudo ln -s ~/wine/bin/wine64 /usr/local/bin/ ;
    echo "Press Enter";
    read;
    InstallWine;;
  7)
    MenuBoxWine;;
 
## Later implement alternative wine version like Vanilla, Staging, Proton, Wayland...
## https://github.com/Kron4ek/Wine-Builds
  esac
  MenuBoxWine
}

function InstallWinetricks {
  echo "In the future"
  echo "Press Enter"
  read
  MainMenu
}

function InstallDXVK {
  echo "In the future"
  echo "Press Enter"
  read
  MainMenu
}

function Xonotic {
	#  Downloading all the dependency for the game and for the compilation process
 	#sudo apt install git build-essential automake libgmp-dev libjpeg-dev libsdl2-dev
	#sudo apt install libcurl4 rsync libpng16-16 libfreetype6 libvorbisfile3
	sudo apt-get install autoconf automake build-essential curl git libtool libgmp-dev libjpeg-turbo8-dev libsdl2-dev libxpm-dev xserver-xorg-dev zlib1g-dev unzip zip
	#Creating a working folder
	mkdir ~/Games # Just pass to the next command if the folder already exist
	cd ~/Games
	mkdir Xonotic
	cd Xonotic
	# Downloading the last source from GIT (here the tutorial : https://gitlab.com/xonotic/xonotic/-/wikis/Git
	git clone https://gitlab.com/xonotic/xonotic.git
	cd xonotic
	./all update -l best
	# Compile, the "-r" is to remove debug flag
	./all compile -r
 	cd
 	
}

MainMenu
exit
echo "Don't show me this text"

## https://github.com/Justineta/BOX86-BOX64-WINEx86-TUTORIAL for the base script
echo "Installing things like build-essential and git from repo"
sudo apt update && sudo apt install build-essential git curl libxpresent1



## And box86:armhf (https://box86.debian.ryanfortner.dev/)(not needed)
#sudo dpkg --add-architecture armhf
#sudo apt-get update
# proceed to add the repo using instructions above
#sudo apt-get install box86-rpi4arm64:armhf


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
read -p "press Enter if you read the text above "
winecfg

## libxpresent1 seems to be needed on my side for winetricks to work

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

## For FSR https://github.com/Kron4ek/Wine-Builds/releases/tag/6.12.1-092f3b1

# https://github.com/neofeo/BOX86-BOX64-WINEx86-TUTORIAL
# https://github.com/NicoD-SBC/armbian-gaming/blob/main/armbian-gaming.sh
# https://github.com/ptitSeb/box86
# https://github.com/ptitSeb/box64

