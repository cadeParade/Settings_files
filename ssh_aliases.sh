# http://www.lainoox.com/bash-aliases-quicker-ssh/
# put blocks like this in ~/.ssh/config
# Host alias-name
#     User username
#     HostName ip.add.re.ss
#     Port 22
#     ForwardX11 yes

# this will make aliases for ip address so you can type `ssh alias-name` to ssh in
for name in `sed -n "/^Host/s/^Host //p" ~/.ssh/config`; do alias $name="$name"; done
