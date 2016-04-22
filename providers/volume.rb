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

use_inline_resources

action :create do
  volume = new_resource.name
  unless exist?(volume)
    converge_by("Creating #{new_resource}") do
      shell_out(volume_create_command).error!
    end
  end
end

action :start do
  volume = new_resource.name
  unless running?(volume)
    converge_by("Starting #{new_resource}") do
      shell_out(
        "#{new_resource.bin} volume start #{new_resource.name}"
      ).error!
    end
  end
end

def base_create_cmd
  "#{new_resource.bin} volume create #{new_resource.name}"
end

def redundancy
  "redundancy #{new_resource.redundancy}" if new_resource.redundancy
end

def arbitrer
  "arbitrer #{new_resource.arbitrer}" if new_resource.arbitrer
end

def force
  'force' if new_resource.force
end

def volume_create_command
  <<-eos
    #{base_create_cmd} \
    #{new_resource.type} #{new_resource.count} \
    #{redundancy} \
    #{arbitrer} \
    transport #{new_resource.transport_type} \
    #{new_resource.mount_points.join(' ')} \
    #{force}
  eos
end

def exist?(volume)
  shell_out(
    "#{new_resource.bin} volume list | grep #{volume}"
  ).exitstatus == 0
end

def running?(volume)
  volume = new_resource.name(new_resource.name)
  shell_out(
    "#{new_resource.bin} volume info #{volume} | grep 'Status: *Started'"
  ).exitstatus == 0
end
