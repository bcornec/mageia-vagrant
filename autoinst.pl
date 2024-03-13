#!/usr/bin/perl -cw
#
# $Id$
#
# 
# You should check the syntax of this file before using it in an auto-install.
# You can do this with 'perl -cw auto_inst.cfg.pl' or by executing this file
# (note the '#!/usr/bin/perl -cw' on the first line).
$o = {
	'timezone' => {
		'ntp' => 'ntp.home.musique-ancienne.org',
		'timezone' => 'Europe/Paris',
		'UTC' => 1
	},
	'services' => [
		'crond',
		'msec',
		'network',
		'ntpd',
		'numlock',
		'partmon',
		'resolvconf',
		'shorewall',
		'sshd'
	],
	'security_user' => 'bruno@musique-ancienne.org',
	'enabled_media' => [
           'Core Release',
           'Core Updates',
#           'Nonfree Release',
#           'Nonfree Updates',
         ],
	'default_packages' => [
		'basesystem',
		#'dhcp-client',
		'drakxtools-curses',
		'ethtool',
		'kernel-server-latest',
		'locales-fr',
		'lsof',
		'msec',
		'nss',
		'ntpd',
		'numlock',
		'openssh-server',
		'openssh-client',
		'shorewall',
		'shorewall-doc',
		'strace',
		'sudo',
		'traceroute',
		'vim-enhanced',
		'vlock',
		'wget',
	],
	'users' => [
		{
			'icon' => 'default',
			'realname' => 'fwadmin',
			'uid' => undef,
			'groups' => [],
			'name' => 'fwadmin',
			'shell' => '/bin/bash',
			'gid' => undef,
			# linux1
			'pw' => '$2a$08$37k9US2q3ST4eLFeR/.ype6SaYD3KgRL5ODOPjH9yStTKVW1zTDm.',
		}
	],
	'locale' => {
		'country' => 'FR',
		'IM' => undef,
		'lang' => 'fr',
		'langs' => {
			'fr' => 1
		},
		'utf8' => 1
	},
	'net' => {
		'zeroconf' => {},
		'network' => {
			'NETWORKING' => 'yes',
			'GATEWAY' => '192.168.8.254',
			'CRDA_DOMAIN' => 'FR',
			'FORWARD_IPV4' => 'false'
		},
		'autodetect' => {},
		'network::connection::ethernet' => {},
		'resolv' => {
			'DOMAINNAME' => 'nameserver',
			'dnsServer' => '192.168.8.2',
			'DOMAINNAME2' => 'search',
			'dnsServer2' => 'home.musique-ancienne.org',
		},
		'wireless' => {},
		'ifcfg' => {
			'eth0' => {
				'BROADCAST' => '',
				'isUp' => 1,
				'BOOTPROTO' => 'dhcp',
				'isPtp' => '',
				'NETWORK' => '',
				'HWADDR' => undef,
				'DEVICE' => 'eth0',
				'METRIC' => 10
		 	}
		},
		'type' => 'network::connection::ethernet',
		'net_interface' => 'eth0',
		'PROFILE' => 'default'
	},
	'authentication' => {
		'shadow' => 1,
		'blowfish' => 1
	},
	'partitions' => [
		 {
			'fs_type' => 'ext4',
			'mntpoint' => '/',
			# 500 MB => 20G
			'size' => 1138567,
			'ratio' => 100,
		 },
		 {
			'fs_type' => 'swap',
			'mntpoint' => 'swap',
			# 1 GB
			'size' => 2038086,
		 },
		],
	'partitioning' => {
		'auto_allocate' => 1,
		'clearall' => 1,
		'eraseBadPartitions' => 1
	},
	'superuser' => {
		# linux1
		'pw' => '$2a$08$37k9US2q3ST4eLFeR/.ype6SaYD3KgRL5ODOPjH9yStTKVW1zTDm.',
		'realname' => 'root',
		'uid' => '0',
		'shell' => '/bin/bash',
		'home' => '/root',
		'gid' => '0'
	 },
	'security' => 'secure',
	'mouse' => {
		'EmulateWheel' => undef,
		'synaptics' => undef,
		'name' => 'Any PS/2 & USB mice',
		'device' => 'input/mice',
		'evdev_mice' => [
				 {
				'device' => '/dev/input/by-id/usb--event-mouse',
				'HWheelRelativeAxisButtons' => '7 6'
				 }
				],
		'evdev_mice_all' => [
				  {
					'device' => '/dev/input/by-id/usb--event-mouse',
					'HWheelRelativeAxisButtons' => '7 6'
				  }
				],
		'type' => 'Universal',
		'nbuttons' => 7,
		'Protocol' => 'ExplorerPS/2',
		'wacom' => [],
		'MOUSETYPE' => 'ps/2'
	},
	'interactiveSteps' => [
	],
	'autoExitInstall' => '1',
	'no_suggests' => 1,
	#'mkbootdisk' => 0,
	'isUpgrade' => 0,
	'excludedocs' => 0,
	'miscellaneous' => {
		'numlock' => 1,
	},
	'keyboard' => {
		'GRP_TOGGLE' => '',
		'KEYBOARD' => 'us'
	},
	'postInstall' => '
	cd /root 
	echo "System automatically installed by build-vagrant-mageia-box.sh" > README
	wget http://192.168.8.2/pub/ks/www/post-install.sh
	chmod 755 ./post-install.sh
	#./post-install.sh 2>&1 | tee /dev/tty7 | tee /var/log/post-install.log
	rm -f ./post-install.sh
	',
	};
