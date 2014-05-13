graphite Cookbook
================
Simply install Graphite that use MySQL Backend.

Requirements
------------
* CentOS6/Amazon Linux 2014.03.1
* Chef 11 or higher
* mysql - Opscode cookbook
* database - Opscode cookbook
* yum - Opscode cookbook
* openssl - Opscode cookbook

Attributes
----------
```ruby
default[:grahite][:timezone]       = "Asia/Tokyo"
default[:grahite][:mysql_password] = "graphite"
```

#### grahite::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['grahite']['mysql_password']</tt></td>
    <td>String</td>
    <td>MySQL password for graphite user</td>
    <td><tt>graphite</tt></td>
  </tr>
  <tr>
    <td><tt>['grahite']['timezone']</tt></td>
    <td>String</td>
    <td>Timezone</td>
    <td><tt>Asia/Tokyo</tt></td>
  </tr>
</table>

Usage
-----
#### grahite::default

e.g.
Just include `grahite` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[graphite]"
  ]
}
```

License and Authors
-------------------
License: MIT License

Authors: Marcy
