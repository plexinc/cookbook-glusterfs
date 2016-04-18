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

yum_repository 'epel' do
  description 'Extra Packages for Enterprise Linux 7'
  mirrorlist node['epel']['mirrorlist']
  gpgkey node['epel']['gpgkey']
  action :create
end

gluster_base_url = node['glusterfs']['baserepo']
gluster_url = node['glusterfs']['endpointrepo']

yum_repository 'glusterfs-epel' do
  description 'GlusterFS repository'
  baseurl "#{gluster_base_url}/#{gluster_url}"
  gpgkey "#{gluster_base_url}/LATEST/rsa.pub"
  action :create
end
