#
# Copyright (c) 2015-2016 Sam4Mobile
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# GlusterFS version
default['glusterfs']['major_version'] = '3.7'
default['glusterfs']['patch_version'] = 'LATEST'

major = node['glusterfs']['major_version']
version = "#{major}/#{node['glusterfs']['patch_version']}"
version = 'LATEST' if major == 'LATEST'

# Auto-upgrade package ?
default['glusterfs']['auto-upgrade'] = false

# EPEL repository
default['glusterfs']['epel']['mirrorlist'] =
  'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=$basearch'

default['glusterfs']['epel']['gpgkey'] =
  'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'

# GlusterFS repository
default['glusterfs']['baseurl'] =
  'http://download.gluster.org/pub/gluster/glusterfs'
baseurl = node['glusterfs']['baseurl']

default['glusterfs']['repo_url'] =
  "#{baseurl}/#{version}/EPEL.repo/epel-$releasever/$basearch"

default['glusterfs']['gpgkey'] =
  "#{node['glusterfs']['baseurl']}/LATEST/rsa.pub"

# Cluster configuration with cluster-search
# Role used by the search to find other nodes of the cluster
default['glusterfs']['role'] = 'glusterfs'
# Hosts of the cluster, deactivate search if not empty
default['glusterfs']['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default['glusterfs']['size'] = 1

# Define who is the initiator, this is him who probes all other nodes and
# creates/configures volumes
default['glusterfs']['initiator_id'] = 1

# Define volumes
default['glusterfs']['volumes'] = {}

# Define client mount points
default['glusterfs']['client']
