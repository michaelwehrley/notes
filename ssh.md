# SSH

* Protocol like HTTP
* Secure Shell is a _cryptographic network protocol_ that provides a secure channel for connecting an SSH client application with an SSH server.
* _SSH-1_ and *SSH-2* are the two major protocol versions.

## Generate

`ssh-keygen -t rsa -b 4096 -C "mike@example.com"` or
`ssh-keygen -t rsa -C "mike@example.com"``

## Usage

* By default, the protocol will look for the `id_rsa` (private key) file.

Implicit: `ssh bob@11.111.11.11`

Explicit:`ssh -i ~/.ssh/digital_ocean bob@11.111.11.11`

* It will add the IP address (i.e., 11.111.11.11) into `~/.ssh/known_hosts` directory.

## Copy

`cat ~/.ssh/id_rsa.pub | pbcopy`

## SCP - Secure Copy Protocol

* Is a based off of SSH and uses SSH for data transfer and uses the same mechanisms for authentication.

## Notes

Warning: the ECDSA host key for 'somewhere.com' differs from the key for the IP address 'XXX.XXX.XXX.XXX'

`$ man ssh-keygen`
-R hostname
           Removes all keys belonging to hostname from a known_hosts file.  This option is useful to delete hashed hosts (see the -H option above).
