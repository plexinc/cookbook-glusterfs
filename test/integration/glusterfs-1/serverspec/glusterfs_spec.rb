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

require 'spec_helper'

describe package('glusterfs-server') do
  it { should be_installed }
end

describe service('glusterd') do
  it { should be_running }
  it { should be_enabled }
end

describe port(24_007) do
  it { should be_listening }
end

describe command(
  'gluster volume info | grep -A5 myvol | grep -B 3 Started'
) do
  its(:exit_status) { should eq 0 }
end

describe command(
  'gluster peer status | grep "Number of Peers:" | grep "2"'
) do
  its(:exit_status) { should eq 0 }
end
