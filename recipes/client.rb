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

# Install glusterfs conf
%w(glusterfs glusterfs-fuse attr).each do |pkg|
  package pkg
end

node['glusterfs']['mounts'].each_pair do |name, conf|
  directory conf['mount_point'] do
    recursive true
    action :create
  end
  mount conf['mount_point'] do
    device "#{conf['server']}:/#{name}"
    fstype 'glusterfs'
    options conf['mount_options'] if conf['mount_options']
    action [:enable, :mount]
    only_if "gluster --remote-host=#{conf['server']} \
                 volume info #{name} | grep 'Status: Started'"
  end
end
