#!/bin/bash
### Personal public script ###
## Gaming with Armbian
## @Justineta 

function menu {
echo "Choose the native arm game you want : "
echo "1. Open arena (fast fps game based on quake). "
echo "2. Xmoto (2d challenging moto game). "
echo "0. Exit "

read choicevar
if [ $choicevar -eq 1 ]
	then 
	box64
elif [ $choicevar -eq 2 ]
	then 
	box86
elif [ $choicevar -eq 3 ]
	then 
	wine64
elif [ $choicevar -eq 4 ]
	then 
	winex86
elif [ $choicevar -eq 5 ]
	then 
	winetricksInstall
elif [ $choicevar -eq 6 ]
	then
	installSteam
elif [ $choicevar -eq 7 ]
	then 
	installPPSSPP
# elif [ $choicevar -eq 8 ]
#	then 
#	buildDolphin
## This script install common linux native games included in the repo
sudo apt update
sudo apt install xmoto openarena supertuxkart extremetuxracer torcs supertux alien-arena assaultcube sauerbraten nexuiz 0ad warzone2100 
