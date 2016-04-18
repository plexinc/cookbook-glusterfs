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
  if been_created?(volume)
    converge_by("Creating #{new_resource}") do
      volume_create
    end
  end
end

action :start do
  volume = new_resource.name
  if been_started?(volume)
    converge_by("Starting #{new_resource}") do
      shell_out(
        "#{new_resource.bin} volume start #{new_resource.name}"
      ).error!
    end
  end
end

action :expand do
  volume = new_resource.name
  if been_started?(volume)
    converge_by("Expanding #{new_resource}") do
      shell_out(
        "#{new_resource.bin} volume add-brick #{volume} \
           #{new_resource.mount_points}"
      ).error!
    end
  end
end

def default_volume_command
  "#{new_resource.bin} volume create #{new_resource.name} \
    #{new_resource.type} #{new_resource.type_number} \
    #{new_resource.redundancy} \
    transport #{new_resource.transport_type} \
    #{new_resource.mount_points.join(' ')} force"
end

def volume_create
  shell_out(default_volume_command).error!
end

def been_created?(volume)
  shell_out(
    "#{new_resource.bin} volume list| grep #{volume}"
  ).exitstatus == 1
end

def been_started?(volume)
  volume = new_resource.name(new_resource.name)
  shell_out(
    "#{new_resource.bin} volume info #{volume} \
      | grep Status \
      | awk '{print $2}' \
      | grep 'Started'"
  ).exitstatus == 1
end
