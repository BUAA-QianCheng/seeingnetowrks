//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package seeingnetworks.simulations.chapter2_linklayer_part_I;

import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

network SimpleEthernet 
{
    submodules:
        host1: StandardHost {
            @display("p=120,90");
        }
        host2: StandardHost {
            @display("p=180,90");
        }
        host3: StandardHost {
            @display("p=260,90");
        }
        host4: StandardHost {
            @display("p=320,90");
        }
        switch1: EtherSwitch {
            @display("p=150,30");
        }
        switch2: EtherSwitch {
            @display("p=290,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
    connections:
        host1.ethg++ <--> Eth100M <--> switch1.ethg++;
        host2.ethg++ <--> Eth100M <--> switch1.ethg++;
        host3.ethg++ <--> Eth100M <--> switch2.ethg++;
        host4.ethg++ <--> Eth100M <--> switch2.ethg++;
        switch1.ethg++ <--> Eth100M <--> switch2.ethg++;
}

network BroadcastStorm extends SimpleEthernet
{
	connections:
		switch1.ethg++ <--> Eth100M <--> switch2.ethg++;	    
}

network VlanConfig 
{
    parameters:
        int numHosts = 6;
	submodules:
		host[numHosts]: StandardHost {
			@display("p=110,90,r,60");
		}
        switch: EtherSwitch {
            @display("p=260,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
    connections:
    	for i=0..numHosts-1{
        	host[i].ethg++ <--> Eth100M <--> switch.ethg++;
    	}
}

