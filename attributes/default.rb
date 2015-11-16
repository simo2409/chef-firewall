default["firewall"]["conf"]["path"] = '/etc/sysconfig/iptables'
default['firewall']['open_ports']['sshd'] = node["openssh"]["server"]["port"] || nil
