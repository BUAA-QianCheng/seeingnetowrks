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

package seeingnetworks.simulations.chapter3_networklayer;

import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.StandardHost;
import inet.node.inet.Router;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;

network NetworkConfig
{
    parameters:
        int numHosts;
    submodules:
        router1: Router {
            @display("p=190,80");
        }
        router2: Router {
            @display("p=285,125");
        }
        router3: Router {
            @display("p=370,80");
        }
        switch1: EtherSwitch {
            @display("p=150,150;t=lan1");
        }
        switch2: EtherSwitch {
            @display("p=285,195;t=lan2");
        }
        switch3: EtherSwitch {
            @display("p=410,150;t=lan3");
        }
        lan1Host[numHosts]: StandardHost {
            @display("p=110,220,r,80");
        }
        lan2Host[numHosts]: StandardHost {
            @display("p=245,265,r,80");
        }
        lan3Host[numHosts]: StandardHost {
            @display("p=370,220,r,80");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
		connections:
		    for i=0..numHosts-1 {
		    	lan1Host[i].ethg++ <--> Eth100M <--> switch1.ethg++;
		    	lan2Host[i].ethg++ <--> Eth100M <--> switch2.ethg++;
		    	lan3Host[i].ethg++ <--> Eth100M <--> switch3.ethg++;
		    }
		    switch1.ethg++ <--> Eth100M <--> router1.ethg++;
		    switch2.ethg++ <--> Eth100M <--> router2.ethg++;
		    switch3.ethg++ <--> Eth100M <--> router3.ethg++;
		    router1.ethg++ <--> Eth100M <--> router2.ethg++;
		    router2.ethg++ <--> Eth100M <--> router3.ethg++;
		    router1.ethg++ <--> Eth100M <--> router3.ethg++;
}

network CrossVlan
{
    submodules:
        host1: StandardHost {
            @display("p=120,150");
        }
        host2: StandardHost {
            @display("p=180,150");
        }
        host3: StandardHost {
            @display("p=260,150");
        }
        host4: StandardHost {
            @display("p=320,150");
        }
        switch: EtherSwitch {
            @display("p=220,90");
        }
        router: Router {
            @display("p=220,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
    connections:
        host1.ethg++ <--> Eth100M <--> switch.ethg++;
        host2.ethg++ <--> Eth100M <--> switch.ethg++;
        switch.ethg++ <--> Eth100M <--> router.ethg++;
        host3.ethg++ <--> Eth100M <--> switch.ethg++;
        host4.ethg++ <--> Eth100M <--> switch.ethg++;
        switch.ethg++ <--> Eth100M <--> router.ethg++;
}
