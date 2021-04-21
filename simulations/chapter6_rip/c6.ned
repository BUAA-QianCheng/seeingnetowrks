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

package seeingnetworks.simulations.chapter6_rip;

import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.integrated.IntegratedMultiCanvasVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.common.scenario.ScenarioManager;
import inet.networklayer.ipv4.RoutingTableRecorder;

network RouterNetwork
{
    submodules:
        host1: StandardHost {
            @display("p=130,155;i=device/pc2,red");
        }
        host2: StandardHost {
            @display("p=690,155;i=device/pc2,blue");
        }
        router1: Router {
            @display("p=250,155");
        }
        router2: Router {
            @display("p=350,75");
        }
        router3: Router {
            @display("p=380,270");
        }
        router4: Router {
            @display("p=420,175");
        }
        router5: Router {
            @display("p=490,75");
        }
        router6: Router {
            @display("p=570,155");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedMultiCanvasVisualizer {
            @display("p=40,90");
        }
    connections:
        host1.ethg++ <--> Eth100M <--> router1.ethg++;
		host2.ethg++ <--> Eth100M <--> router6.ethg++;
        router1.ethg++ <--> Eth100M <--> router2.ethg++;
        router1.ethg++ <--> Eth100M <--> router3.ethg++;
        router2.ethg++ <--> Eth100M <--> router4.ethg++;
        router3.ethg++ <--> Eth100M <--> router4.ethg++;
        router2.ethg++ <--> Eth100M <--> router5.ethg++;
        router3.ethg++ <--> Eth100M <--> router6.ethg++;
        router4.ethg++ <--> Eth100M <--> router6.ethg++;
        router5.ethg++ <--> Eth100M <--> router6.ethg++;
}

network RouterNetworkExt extends RouterNetwork
{
    submodules:
        scenarioManager: ScenarioManager {
            @display("p=40,150");
        }
        rtr: RoutingTableRecorder {
            @display("p=40,210");
        }
}
