GlusterFS
=========

Description
-----------

GlusterFS is a scalable network filesystem. Using common off-the-shelf
hardware, you can create large, distributed storage solutions for media
streaming, data analysis, and other data- and bandwidth-intensive tasks.
GlusterFS is free and open source software.

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

Set `node['glusterfs']['hosts']` to an array containing the hostnames of
the nodes of the GlusterFS cluster. By default it is set to
`[localhost]`.

### Search

It is also possible to let the *config* recipe use a search to find the members
of a cluster. First you need to set `node['glusterfs']['role']` to `[]`. Then
The search is parametrized by a role name, defined in attribute
`node['glusterfs']['role']` which default to *glusterfs*. Node having this role
in their expanded runlist will be considered in the same GlusterFS cluster. For
safety reason, if search is used, you need to define
`node['glusterfs']['size']` (1 by default). The cookbook will return (with
success) until the search return *size* nodes. This ensures the stability of
the configuration during the initial startup of a cluster.

Be sure to set `node['glusterfs']['hosts']` to `[]` if you want to use search
as by default it is set to `[localhost]` which deactivates search and ignore
*size* attribute.

### Test

This cookbook is fully tested through the installation of a working 3-nodes
cluster in docker hosts. This uses kitchen (>= 1.5.0), docker (>= 1.10) and
a small monkey-patch.

At the moment, the docker images are run in privileged mode which is highly
insecure. This is needed by GlusterFS to mount volumes. You are invited to
check the image used (sbernard/centos-systemd-kitchen) for the tests before
running them.

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

Permit access to GlusterFS volumes using Gluster Native Client method

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

- Author:: Samuel Bernard (<samuel.bernard@s4m.io>)
- Author:: Florian Philippon (<florian.philippon@s4m.io>)

```text
Copyright (c) 2016 Sam4Mobile

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
