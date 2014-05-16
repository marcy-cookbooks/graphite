graphite Cookbook
================
Simple Install and configure metrics monitoring tool "Graphite".

This cookbook can be used to making "Grafana" dashboard.

Requirements
------------
* CentOS6 or Amazon Linux 2014.03.1
* Chef 11 or higher
* mysql    - Opscode cookbook
* database - Opscode cookbook
* yum      - Opscode cookbook
* openssl  - Opscode cookbook

Attributes
----------
#### grahite::default
```ruby
#Graphite Web Settings
default[:graphite][:timezone]         = "Asia/Tokyo"
default[:graphite][:mysql_password]   = "graphite"
default[:graphite][:http_port]        = 80
default[:graphite][:http_server_name] = "graphite-web"
#Carbon Settings
default[:grahite][:storage_dir]               = "/var/lib/carbon/"
default[:grahite][:local_data_dir]            = "/var/lib/carbon/whisper/"
default[:grahite][:enable_log_rotation]       = true
default[:grahite][:max_updates_per_second]    = 500
default[:grahite][:max_creates_per_miniute]   = 50
default[:grahite][:line_receiver_interface]   = "0.0.0.0"
default[:grahite][:line_receiver_port]        = 2003
default[:grahite][:enable_udp_listener]       = false
default[:grahite][:udp_receiver_interface]    = "0.0.0.0"
default[:grahite][:udp_receiver_port]         = 2003
default[:grahite][:pickle_receiver_interface] = "0.0.0.0"
default[:grahite][:pickle_receiver_port]      = 2004
default[:grahite][:log_listener_connections]  = true
default[:grahite][:use_insecure_unpickler]    = false
default[:grahite][:cache_query_interface]     = "0.0.0.0"
default[:grahite][:cache_query_port]          = 7002
default[:grahite][:use_flow_control]          = true
default[:grahite][:log_updates]               = false
default[:grahite][:log_cache_hits]            = false
default[:grahite][:log_cache_queue_sorts]     = true
default[:grahite][:cache_write_strategy]      = "sorted"
default[:grahite][:whisper_fallocate_create]  = true
default[:grahite][:whisper_autoflush]         = false
```

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
