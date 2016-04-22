#
# Copyright (c) 2016 Sam4Mobile
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

# Use ClusterSearch
::Chef::Recipe.send(:include, ClusterSearch)

gluster_cluster = cluster_search(node['glusterfs'])
return if gluster_cluster.nil?

initiator_id = node['glusterfs']['initiator_id']
if initiator_id < 1 || initiator_id > gluster_cluster['hosts'].size
  raise 'Invalid initiator_id, should be between 1 and cluster.size'
end

raise 'Cannot find myself in the cluster' if gluster_cluster['my_id'] == -1

if gluster_cluster['my_id'] == initiator_id
  # Probe hosts into the GlusterFS cluster
  gluster_cluster['hosts'].each do |host|
    glusterfs_probe host
  end

  # Configure and start GlusterFS volumes based on attributes
  node['glusterfs']['volumes'].each_pair do |name, conf|
    resource = glusterfs_volume name
    conf.each_pair do |key, value|
      value = [value] unless value.is_a? Array
      resource.send(key, *value)
    end
  end
end
