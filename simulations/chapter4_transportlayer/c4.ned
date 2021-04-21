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

package seeingnetworks.simulations.chapter4_transportlayer;

import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.common.scenario.ScenarioManager;
import inet.common.misc.ThruputMeteringChannel;

network NetworkBase 
{
    submodules:
        host1: StandardHost {
            @display("p=120,90");
        }
        host2: StandardHost {
            @display("p=280,90");
        }
        switch: EtherSwitch {
            @display("p=200,90");
        }
        router: Router {
            @display("p=200,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
}

network TinyNetwork extends NetworkBase 
{
    types:
    	channel C extends ThruputMeteringChannel{
            parameters:
                datarate = 10Mbps;
                delay = 5ms;
                per = 0;
                ber = 0;
                thruputDisplayFormat = default("N B P U");
        }
    connections:
        host1.ethg++ <--> C <--> switch.ethg++;
		switch.ethg++ <--> C <--> router.ethg++;
        host2.ethg++ <--> C <--> switch.ethg++;
		switch.ethg++ <--> C <--> router.ethg++;
}

network TinyNetworkWithScene extends TinyNetwork 
{
    submodules:
        scenarioManager: ScenarioManager {
            @display("p=40,150");
        }
}

network TinyNetworkWithErr extends NetworkBase 
{
	types:
    	channel C extends ThruputMeteringChannel{
            parameters:
                datarate = 10Mbps;
                delay = 5ms;
                per = 0;
                ber = 0;
                thruputDisplayFormat = default("N B P U");
        }
        channel C_err extends ThruputMeteringChannel{
            parameters:
                datarate = 10Mbps;
                delay = 5ms;
                per = 0.02;
                ber = 0;
                thruputDisplayFormat = default("N B P U");
        }
	connections:
        host1.ethg++ <--> C_err <--> switch.ethg++;
       	switch.ethg++ <--> C <--> router.ethg++;
        host2.ethg++ <--> C <--> switch.ethg++;
		switch.ethg++ <--> C <--> router.ethg++;
}