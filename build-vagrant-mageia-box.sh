#!/usr/bin/bash
#

MGAVER=$1
if [ _"$MGAVER" = _"" ]; then
	echo "Syntax: build-vagrant-mageia-box version"
	exit -1
fi
MGAARCH=`uname -m`
QIMG=mageia-$MGAVER-$MGAARCH

# Based on doc from https://vagrant-libvirt.github.io/vagrant-libvirt/boxes.html
#

if [ ! -d /pub/mageia ]; then
	sudo mount morales:/users/ftp/pub /pub
fi

# First, create automatically a minimal Mageia QEMU qcow2 image
#
echo "Setup bridge"
#sudo virsh net-define mageia.xml
#sudo virsh net-start --network mageia
sudo virsh net-list --name | grep -q default
if [ $? -ne 0 ]; then
	sudo virsh net-start default
fi

echo "Install in automatic mode a mageia-$MGAVER-$MGAARCH QEMU image"
sudo virt-install --connect qemu:///system \
			--name $QIMG \
			--memory 2048 \
			--vcpus 1 \
			--disk size=20 \
			--network bridge=virbr0 \
			--location http://192.168.8.2/pub/mageia/distrib/$MGAVER/$MGAARCH,kernel=isolinux/$MGAARCH/vmlinuz,initrd=isolinux/$MGAARCH/all.rdz \
			--initrd-inject ./autoinst.pl \
			--extra-args "kickstart=/autoinst.pl automatic=method:http,server:192.168.8.2,directory:/pub/mageia/distrib/$MGAVER/$MGAARCH,network:dhcp console=tty0 console=ttyS0,115200n8"
res=$?

QCOW=/var/lib/libvirt/images/$QIMG.qcow2

if [ -f $QCOW ]; then 
	sudo chmod 644 $QCOW
#
# Second, use create_box.sh to transform it
#
	if [ $res -eq 0 ]; then
		echo "Transform the image in a Vagrant Box"
		/usr/share/vagrant/gems/gems/vagrant-libvirt-0.12.2/create_box.sh /var/lib/libvirt/images/$QIMG.qcow2
		res=$?
	fi
	sudo chmod 600 $QCOW
	if [ $res -eq 0 ] && [ -f $QIMG.box ]; then
		echo "Now adding it to the Vagrant boxes"
		vagrant box add $QIMG.box --name $QIMG
	fi
fi
