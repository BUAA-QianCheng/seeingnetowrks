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

package seeingnetworks.simulations.chapter7_ospf;

import ned.DatarateChannel;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.visualizer.integrated.IntegratedMultiCanvasVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.common.scenario.ScenarioManager;
import inet.networklayer.ipv4.RoutingTableRecorder;


network TwoRouters
{
    submodules:
        router1: Router {
            @display("p=240,100");
        }
        router2: Router {
            @display("p=360,100");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedMultiCanvasVisualizer {
            @display("p=40,90");
        }
    connections:
        router1.ethg++ <--> Eth100M <--> router2.ethg++;
}

network AreaNet extends TwoRouters
{
    types:
        channel PppLink100M extends DatarateChannel
        {
            delay = 1us;
            datarate = 100Mbps;
        }
    submodules:
        router3: Router {
            @display("p=160,50");
        }
        router4: Router {
            @display("p=420,150");
        }
        router5: Router {
            @display("p=420,50");
        }
        switch: EtherSwitch {
            @display("p=160,150");
        }
        host1: StandardHost {
            @display("p=100,200");
        }
        host2: StandardHost {
            @display("p=200,200");
        }
    connections:
        router1.pppg++ <--> PppLink100M <--> router3.pppg++;
        router1.ethg++ <--> Eth100M <--> switch.ethg++;
        switch.ethg++ <--> Eth100M <--> host1.ethg++;
        switch.ethg++ <--> Eth100M <--> host2.ethg++;
        router2.pppg++ <--> PppLink100M <--> router4.pppg++;
        router2.pppg++ <--> PppLink100M <--> router5.pppg++;
}

network MultiArea
{
    types:
        channel PppLink100M extends DatarateChannel
        {
            delay = 5us;
            datarate = 100Mbps;
        }
    submodules:
        router1: Router {
            @display("p=160,135");
        }
        router2: Router {
            @display("p=300,75");
        }
        router3: Router {
            @display("p=360,135");
        }
        router4: Router {
            @display("p=260,135");
        }
        switch1: EtherSwitch {
            @display("p=100,135");
        }
        switch2: EtherSwitch {
            @display("p=330,30");
        }
        switch3: EtherSwitch {
            @display("p=420,135");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedMultiCanvasVisualizer {
            @display("p=40,90");
        }
        extrouter: Router {
            @display("p=220,194");
        }
    connections:
        router1.pppg++ <--> PppLink100M <--> router4.pppg++;
        router2.pppg++ <--> PppLink100M <--> router4.pppg++;
        router3.pppg++ <--> PppLink100M <--> router4.pppg++;
        extrouter.pppg++ <--> PppLink100M <--> router4.pppg++;
        router1.ethg++ <--> Eth100M <--> switch1.ethg++;
        router2.ethg++ <--> Eth100M <--> switch2.ethg++;
        router3.ethg++ <--> Eth100M <--> switch3.ethg++;
}

network RouterRing
{
    parameters:
        int numRouter;
    types:
        channel PppLink100M extends DatarateChannel
        {
            delay = 20us;
            datarate = 100Mbps;
        }
    submodules:
        router[numRouter]: Router {
            @display("p=100,50,ri,200,100");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedMultiCanvasVisualizer {
            @display("p=40,90");
        }
    connections:
        for i=0..numRouter-2 {
            router[i].ethg++ <--> PppLink100M <--> router[i+1].ethg++;
        }
        router[numRouter-1].ethg++ <--> PppLink100M <--> router[0].ethg++;
}

network RouterMap
{
    types:
		channel EthLink100M extends DatarateChannel
        {
            delay = 20us;
            datarate = 100Mbps;
        }
    submodules:
        host1: StandardHost {
        	@display("p=100,160;i=device/pc2,red");	
        }
        host2: StandardHost {
        	@display("p=900,160;i=device/pc2,blue");
        }
        RA: Router {
            @display("p=200,160");
        }
        RB[2]: Router {
            @display("p=300,100,c,120");
        }
        RC[4]: Router {
            @display("p=400,40,c,80");
        }
        RD[3]: Router {
            @display("p=500,80,c,80");
        }
        RE[3]: Router {
            @display("p=600,80,c,80");
        }
        RF[2]: Router {
            @display("p=700,100,c,120");
        }
        RG: Router {
            @display("p=800,160");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedMultiCanvasVisualizer {
            @display("p=40,90");
        }
    connections:
        host1.ethg++ <--> EthLink100M <--> RA.ethg++;
        RA.ethg++ <--> EthLink100M <--> RB[0].ethg++;
        RA.ethg++ <--> EthLink100M <--> RB[1].ethg++;
        for i=0..2 {
        	RB[0].ethg++ <--> EthLink100M <--> RC[i].ethg++;
        	RB[1].ethg++ <--> EthLink100M <--> RC[i+1].ethg++;
        }
        for i=0..1 {
        	RC[0].ethg++ <--> EthLink100M <--> RD[i].ethg++;
        	RC[1].ethg++ <--> EthLink100M <--> RD[i].ethg++;
        	RC[2].ethg++ <--> EthLink100M <--> RD[i+1].ethg++;
        	RC[3].ethg++ <--> EthLink100M <--> RD[i+1].ethg++;
        	
        	RD[0].ethg++ <--> EthLink100M <--> RE[i].ethg++;
        	RD[1].ethg++ <--> EthLink100M <--> RE[i+1].ethg++;
        	RD[2].ethg++ <--> EthLink100M <--> RE[i+1].ethg++;
        	
        	RE[0].ethg++ <--> EthLink100M <--> RF[i].ethg++;
        	RE[1].ethg++ <--> EthLink100M <--> RF[i].ethg++;
        	RE[2].ethg++ <--> EthLink100M <--> RF[i].ethg++;
        	RF[i].ethg++ <--> EthLink100M <--> RG.ethg++;
        }
        RG.ethg++ <--> EthLink100M <--> host2.ethg++;
}


