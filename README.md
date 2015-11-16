firewall Cookbook
=================
This cookbook is much opinionated.
This cookbook uses CentOS 7, doesn't like firewalld and loves iptables.

With this cookbook you can define rules for your iptables on CentOS 7.

By default this recipe deny all ports except ones specified in configuration

Requirements
------------
This cookbook requires:
- `firewall cookbook` - https://github.com/chef-cookbooks/firewall

Attributes
----------

```json
"firewall": {
  "open_ports": {
    "sshd": 22,
    "tcp": [80, 443],
    "udp": []
  }
}
```

#### firewall::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['firewall']['open_ports']['sshd']</tt></td>
    <td>Number</td>
    <td>SSHd port</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['open_ports']['tcp']</tt></td>
    <td>Array</td>
    <td>list of TCP ports to be open</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['firewall']['open_ports']['udp']</tt></td>
    <td>Array</td>
    <td>list of UDP ports to be open</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
#### firewall::default
Just include `firewall` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[firewall]"
  ]
}
```
and specify which ports you need open.

Contributing
------------
Need help for testing following best practises, if you can help you are welcome!

License and Authors
-------------------
License: MIT

Authors:

Simone Dall'Angelo
