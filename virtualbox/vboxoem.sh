#  mod of robwiss's original script 
#  found here: https://forums.virtualbox.org/viewtopic.php?f=2&t=43678&p=227455
#
#  requires a unique SLIC.bin in home folder 
#  example: sudo dd if="/sys/firmware/acpi/tables/SLIC" of="~/SLIC.bin"
#  use DMIdecode for <EMPTY> tags (or leave as <EMPTY> to "reset" the mod)
#  requires a Windows 7 OEM iso
#  avoid naming the vm with multiple words
#! /bin/bash
VM_NAME="Windows" #change as needed
VM_KEY="" # activation key (not currently used)
TABLE_PATH="VBoxInternal/Devices/acpi/0/Config/SLICTable" # vbox default
SLIC_PATH="~/SLIC.BIN" # location of SLIC dump, needed for activation
CFG_PATH="VBoxInternal/Devices/pcbios/0/Config"

VSETED="VBoxManage setextradata $VM_NAME"
$VSETED $TABLE_PATH $SLIC_PATH
$VSETED $CFG_PATH/DmiBIOSVendor       "<EMPTY>"
$VSETED $CFG_PATH/DmiBIOSVersion      "<EMPTY>"
$VSETED $CFG_PATH/DmiBIOSReleaseDate  "<EMPTY>"
$VSETED $CFG_PATH/DmiBIOSReleaseMajor	"<EMPTY>"
$VSETED $CFG_PATH/DmiBIOSReleaseMinor  "<EMPTY>"
$VSETED $CFG_PATH/DmiBIOSFirmwareMajor "<EMPTY>"
$VSETED $CFG_PATH/DmiBIOSFirmwareMinor "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemVendor     "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemProduct    "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemVersion    "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemSerial     "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemUuid       "<EMPTY>"
$VSETED $CFG_PATH/DmiSystemFamily     "<EMPTY>"
