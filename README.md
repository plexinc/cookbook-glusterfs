GlusterFS
==================

Description
-----------

GlusterFS is a scalable network filesystem.

This cookbook focuses on deploying a GlusterFS cluster via Chef.

Requirements
------------

### Cookbooks and gems

Declared in [metadata.rb](metadata.rb) and in [Gemfile](Gemfile).

### Platforms

A *systemd* managed distribution:
- RHEL Family 7, tested on Centos 7.2

Usage
-----

### Easy Setup

Create a role `glusterfs` having `recipe['glusterfs']` in its
runlist and setting `node['glusterfs']['role']` to itself. Add this
role in the runlists of the nodes you want to use for your cluster. By default,
you need exactly 3 nodes.

### Search

By default, the *config* recipe use a search to find the members of a cluster.
The search is parametrized by a role name, defined in attribute
`node['glusterfs']['role']` which default to *glusterfs*.
Node having this role in their expanded runlist will be considered in the same
glusterfs cluster. For safety reason, if search is used, you need to define
`node['glusterfs']['size']` (3 by default). The cookbook will return
(with success) until the search return *size* nodes. This ensures the
stability of the configuration during the initial startup of a cluster.

If you do not want to use search, it is possible to define
`node['glusterfs']['hosts']` with an array containing the hostnames of
the nodes of a glusterfs cluster. In this case, *size* attribute is ignored
and search deactivated.

### Test

This cookbook is fully tested through the installation of a working 3-nodes
cluster in docker hosts. This uses kitchen (>= 1.5.0), docker (>= 1.10) and
a small monkey-patch.

For more information, see *.kitchen.yml* and *test* directory.

Attributes
----------

Configuration is done by overriding default attributes. All configuration keys
have a default defined in [attributes/default.rb](attributes/default.rb).
Please read it to have a comprehensive view of what and how you can configure
this cookbook behavior.

Recipes
-------

* default
* repository (setup yum repositories)
* package (install glusterfs-server)
* service (make sure glusterd service is enabled and started)
* configure (probe an host into the cluster and create a volume)
* client (mount a glusterfs volume)


### Setting Up Clients

Permit access to gluster volumes using Gluster Native Client method

#### Example

```json
"glusterfs": {
  "mounts": {
    "myvol": {
      "mount_point": "/mnt/data",
      "server": "host1.example"
    }
  }
}
```

It creates a mount point on the local filesystem at /mnt/data
using GlusterFS fuse client.

Resources/Providers
-------------------

### Probe

Probe an host into the GlusterFS cluster.

#### Example

```ruby
glusterfs_probe 'my-custom-host.test'
```

### Volume

Create a GlusterFS volume

#### Example

##### Creation of a replicated volume with two storage servers

```json
"glusterfs": {
  "volumes": {
    "myvol": {
      "type": "replica",
      "count": 2,
      "transport_type": "tcp",
      "mount_points": [[
        "host1.example:/mnt/brick1",
        "host2.example:/mnt/brick2",
      ]],
      "action": [["create", "start"]]
    }
  }
}

```

Changelog
---------

Available in [CHANGELOG.md](CHANGELOG).

Contributing
------------

Please read carefully [CONTRIBUTING.md](CONTRIBUTING.md) before making a merge
request.

License and Author
------------------

- Author:: Florian Philippon (<florian.philippon@s4m.io>)

```text
Copyright (c) 2015-2016 Sam4Mobile

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
