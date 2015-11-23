#
# Cookbook Name:: firewall
# Recipe:: default
#
# Copyright 2015, Simone Dall Angelo
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Install iptables
package 'iptables-services' do
  action :install
end

# Disable firewalld
service 'firewalld.service' do
  action [:disable, :stop]
end

# Enable iptables (both ipv4 and ipv6)
['iptables.service', 'ip6tables.service'].each do |iptable|
  service iptable do
    action [:enable, :start]
  end
end

# Remove firewalld
package 'firewalld' do
  action :remove
end

# Adds monit port if recipe is present
if node["monit"]["web_interface"]["port"]
  node["firewall"]["open_ports"]["tcp"] << node["monit"]["web_interface"]["port"]
end

# Setup iptables config
template node["firewall"]["conf"]["path"] do
  source "iptables.erb"
  owner 'root'
  group 'root'
  mode 0644
end

# Reload iptables config
['iptables.service', 'ip6tables.service'].each do |iptable|
  service iptable do
    action :reload
  end
end
