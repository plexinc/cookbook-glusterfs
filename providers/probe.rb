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
  host = new_resource.host
  bin = new_resource.bin
  unless node['fqdn'] == host || probed?(host)
    converge_by("Probe #{host}") do
      execute "#{bin} peer probe #{host}" do
        action :run
      end
      execute 'check_peer_status' do
        command "grep state=3 \"$(grep -l #{host} /var/lib/glusterd/peers/*)\""
        retries new_resource.peer_wait_retries
        retry_delay new_resource.peer_wait_retry_delay
      end
    end
  end
end

def probed?(host)
  shell_out("grep #{host} /var/lib/glusterd/peers/*").exitstatus == 0
end

def whyrun_supported?
  true
end
