%  Copyright 2008 Brian Tanner
%  http://rl-glue-ext.googlecode.com/
%  brian@tannerpages.com
%  http://research.tannerpages.com
%  
%   Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%   You may obtain a copy of the License at
%  
%       http://www.apache.org/licenses/LICENSE-2.0
%  
%   Unless required by applicable law or agreed to in writing, software
%   distributed under the License is distributed on an "AS IS" BASIS,
%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%   See the License for the specific language governing permissions and
%   limitations under the License.
%  
%   $Revision$
%   $Date$
%   $Author$
%  $HeadURL$
%
function response=RL_env_message(message)
		forceConnection();
        global p__rlglueStruct;
        %Send the data to the glue that RL_env_message should be executed
        p__rlglueStruct.network.clearSendBuffer();
        p__rlglueStruct.network.putInt(org.rlcommunity.rlglue.codec.network.Network.kRLEnvMessage);
        p__rlglueStruct.network.putInt(org.rlcommunity.rlglue.codec.network.Network.sizeOf(message));
        p__rlglueStruct.network.putString(message);
        p__rlglueStruct.network.flipSendBuffer();
        p__rlglueStruct.network.send();
        
        %If there is an environment (if we're running more than one
        %component together), then make sure it executes (env_message)
        ensureEnvExecutesIfNecessary();

        %Receive the response from rl_glue

        forceStandardRecv(org.rlcommunity.rlglue.codec.network.Network.kRLEnvMessage);
        response = p__rlglueStruct.network.getString();
end