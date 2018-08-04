#	$OpenBSD: sshd_config,v 1.101 2017/03/14 07:19:07 djm Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/bin:/usr/bin:/sbin:/usr/sbin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

{{ $keys_dir := (getenv "SSHD_HOST_KEYS_DIR" "/etc/ssh") }}
HostKey {{ $keys_dir }}/ssh_rsa_key
HostKey {{ $keys_dir }}/ssh_dsa_key
HostKey {{ $keys_dir }}/ssh_ecdsa_key
HostKey {{ $keys_dir }}/ssh_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
LogLevel {{ getenv "SSHD_LOG_LEVEL" "VERBOSE" }}

# Authentication:

#LoginGraceTime 2m
#PermitRootLogin prohibit-password
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

PubkeyAuthentication yes

# The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
# but this is overridden so installations will only check .ssh/authorized_keys
AuthorizedKeysFile	.ssh/authorized_keys

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication {{ getenv "SSHD_PASSWORD_AUTHENTICATION" "no" }}
#PermitEmptyPasswords no

# Change to no to disable s/key passwords
#ChallengeResponseAuthentication yes

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes

# UsePAM NOT SUPPORTED

#AllowAgentForwarding yes
#AllowTcpForwarding yes
GatewayPorts {{ getenv "SSHD_GATEWAY_PORTS" "no" }}
#X11Forwarding no
#X11DisplayOffset 10
#X11UseLocalhost yes
#PermitTTY yes
#PrintMotd yes
#PrintLastLog yes
#TCPKeepAlive yes
#UseLogin no
PermitUserEnvironment {{ getenv "SSHD_PERMIT_USER_ENV" "no" }}
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
UseDNS {{ getenv "SSHD_USE_DNS" "yes" }}
#PidFile /run/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# override default of no subsystems
Subsystem	sftp	/usr/lib/ssh/sftp-server

# the following are HPN related configuration options
# tcp receive buffer polling. disable in non autotuning kernels
#TcpRcvBufPoll yes

# disable hpn performance boosts
#HPNDisabled no

# buffer size for hpn to non-hpn connections
#HPNBufferSize 2048


# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	PermitTTY no
#	ForceCommand cvs server
