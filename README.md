# Docker-REDHAWK

This repository builds a series of Docker images and scripts for standing up an RPM-based installation of REDHAWK SDR with the exception of `redhawk/usrp` (as of this 2.0.5 release).  For that image, the UHD driver is recompiled to a newer version and the USRP_UHD Device is compiled from source against that newer driver.  The result is access to the latest Ettus Research USRPs from the container.

## Building

To build all images, simply type `make`.  You will end up with the following images that are meant't to be run individually.

* `redhawk/base`: This is the repository installation, omni services (non-running), and an `/etc/omniORB.cfg` update script.
* `redhawk/runtime`: The typical "REDHAWK Runtime" group install.  It is the basis for the `domain` and various device launchers.

The remaining images are derived and come with helper scripts for deploying your system:

 * `redhawk/omniserver`: OmniORB and OmniEvents services wrapped in a single image, intended to be run as a singleton in the network.  If you have an Omni server running elsewhere, you do not need this.
 * `redhawk/domain`: Configured to run as a Domain.
 * `redhawk/gpp`: Configured to run as a GPP -bearing Node.
 * `redhawk/rtl2832u`: Configured to run as an RTL2832U -bearing Node. 
 * `redhawk/usrp`: Configured to run as an USRP_UHD -bearing Node.
 * `redhawk/webserver`: Instantiates the rest-python web server.

 > **Note:** The `rtl2832u`, `usrp`, and `webserver` images are disabled at this time as they are not complete.

 The following scripts will also be linked into the main directory.  Each script supports `-h` and `--help` to learn the usage of the script.

 * `login`: Starts a bash shell as a specified user (optional).
 * `omniserver`: Starts and stops a local OmniORB service either in bridged or networked mode.
 * `sdrroot`: Creates or deletes a Docker volume that can be shared as SDRROOT which can be shared with other containers, such as a Domain or Development (IDE).
 * `domain`: Starts or stops a named REDHAWK domain with, optionally, an SDRROOT volume name and external OmniServer IP address.
 * `gpp`: Starts or stops a GPP for the named domain and external OmniServer IP address.

 > **TBD:** Add `rtl2832u`, `usrp`, and `webserver` management scripts

## Usage

The main elements one needs for a REDHAWK system are the naming and event services (OmniORB and OmniEvents), a Domain, and a GPP.  If the scripts are not in the main directory, use `make scripts` to generate the links.  Each scripts supports the `-h` and `--help` that cover usage.  Below is a simplified example.

    ./omniserver host
    ./domain start REDHAWK_DEV1 DEV1_ROOT

At this point you will have a functioning REDHAWK Domain and GPP pointed at a host-exposed OmniORB server.  Other non-Docker REDHAWK instances can now join this Domain as well as long as your host system's firewall settings expose ports 2809 and 11169.

    ./gpp start -g GPP1 REDHAWK_DEV1

A GPP container launches and joins REDHAWK_DEV1 as the node DevMgr_GPP1.  You can now launch waveforms.

If you would like to join the Domain container, use `login`:

    ./login REDHAWK_DEV1 redhawk

You will enter a bash shell as the `redhawk` user.  

 > **Note:** Not all images have this user defined.  For example, the only user in the `redhawk/omniserver` image is `root`.

## Persistent SDRROOT

Use `make sdrroot.sh` to expose a utility script for creating an SDRROOT volume that can be mounted to the Domain and IDE.

    ./sdrroot.sh create MY_REDHAWK
    ./rhide.sh MY_REDHAWK
    ./domain.sh start MY_DOMAIN MY_REDHAWK

The result will be an IDE instance with access to your SDRROOT 

## Running the IDE

 * `redhawk/development`: Use `make rhide.sh` to get a utility script for starting the IDE.

## Device Node Auto-launchers

TBD.  We'll be adding some udev scripts to automatically launch and configure containers for USRPs, etc. so when you plug something into USB, it boots the container like a docker-borne driver.

