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
    "recipe[grahite]"
  ]
}
```

Contributing
------------

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: MIT License

Authors: Marcy
