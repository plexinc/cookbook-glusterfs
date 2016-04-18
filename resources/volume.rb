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

actions :create, :start, :expand
default_action :create

attribute :name, kind_of: String, name_attribute: true
attribute :type, kind_of: String, required: false
attribute :type_number, kind_of: Integer, required: false
attribute :redundancy, kind_of: String, required: false
attribute :transport_type, kind_of: String, required: false, default: 'tcp'
attribute :mount_points, kind_of: Array, required: true
attribute :bin, kind_of: String, required: false, default: '/usr/sbin/gluster'
