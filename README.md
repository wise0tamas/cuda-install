# Purpose

Install CUDA virtual package, after updating the Debian 12 base system to current.

# steps:

* phase #1: include contrib + non-free-firmware components, then upgrade to current package versions.
* reboot to new kernel
* phase #2: include official nvidia repo and update apt cache, then
  * install nvidia-driver (currently 560.35.03-1 is the newest stable version)
  * install cuda-driver (currently 560 version is the newest stable version) - this modifies some of the nvidia-driver package(s)
  * install cuda virtual package, which modifies both nvidia-driver and cuda-driver, as well...
* reboot to the kernel, which now has the NVidia drivers, as well.

