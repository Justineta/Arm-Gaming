# Arm-Gaming
Arm-Gaming is an interactive program firstly designed with armbian in mind to install some tools for gaming with your SBC.

Arm-Gaming is a personnal project, some tools are visible but not implemented yet. I work on it when I have the time (programming is not my main job, IT isn't even a job for my).

My main developement platform is an Odroid N2+ but it should work with all single board computer with some mainline GPU drivers (Amlogic, Rockchip, some Samsung Exynoss, and some Qualcomm Snapdragon SoC).
It should also work with other distro if they are Debian based. Other distro can be compatible with a little work to change the APT command by the command for the native package manager. Some tools requiere the usage of multiarch to install armhf (32 bits) into arm64 (64bits) so, some tools will not work with Arch due to the lack of this fonction.

