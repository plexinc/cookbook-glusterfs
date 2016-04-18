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

# EPEL Repo
default['epel']['mirrorlist'] =
  'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=$basearch'

default['epel']['gpgkey'] =
  'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'

default['glusterfs']['baserepo'] =
  'http://download.gluster.org/pub/gluster/glusterfs'

default['glusterfs']['endpointrepo'] =
  'LATEST/EPEL.repo/epel-$releasever/$basearch'

# GlusterFS
default['glusterfs']['server']['pkg_version'] = '3.7.10-1.el7'

# Cluster configuration
# Role used by the search to find other nodes of the cluster
default['glusterfs']['role'] = 'glusterfs'
# Hosts of the cluster, deactivate search if not empty
default['glusterfs']['hosts'] = []
# Expected size of the cluster. Ignored if hosts is not empty
default['glusterfs']['size'] = 3
