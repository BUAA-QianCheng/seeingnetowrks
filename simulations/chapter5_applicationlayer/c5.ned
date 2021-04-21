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

package seeingnetworks.simulations.chapter5_applicationlayer;

import inet.node.ethernet.Eth100M;
import inet.node.ethernet.EtherSwitch;
import inet.common.misc.ThruputMeteringChannel;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.internetcloud.InternetCloud;
import inet.visualizer.integrated.IntegratedVisualizer;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.applications.httptools.configurator.HttpController;
import inet.node.httptools.HttpDirectHost;

network SimpleWan
{
    types:
        channel C extends ThruputMeteringChannel
        {
            parameters:
                datarate = 10Mbps;
                delay = 5ms;
                per = 0;
                ber = 0;
                thruputDisplayFormat = default("P U");
        }
    submodules:
        router: Router {
            @display("p=280,90");
        }
        host1: StandardHost {
            @display("p=140,30");
        }
        host2: StandardHost {
            @display("p=120,90");
        }
        host3: StandardHost {
            @display("p=140,150");
        }
        switch: EtherSwitch {
            @display("p=210,89");
        }
        internet: InternetCloud {
            @display("p=400,90;i=misc/cloud_vl");
        }
        server: StandardHost {
            @display("p=520,90");
        }
        httpController: HttpController {
            @display("p=40,150;i=block/cogwheel");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
    connections:
        host1.ethg++ <--> C <--> switch.ethg++;
        host2.ethg++ <--> C <--> switch.ethg++;
        host3.ethg++ <--> C <--> switch.ethg++;
        switch.ethg++ <--> C <--> router.ethg++;
        router.ethg++ <--> C <--> internet.ethg++;
        server.ethg++ <--> C <--> internet.ethg++;
}

network HttpDirect
{
    parameters:
        int numHost = default(3);
    submodules:
        host[numHost]: HttpDirectHost {
            parameters:
                @display("i=device/laptop;p=150,180,row,100");
        }
        server: HttpDirectHost {
            @display("p=250,60;i=device/server");
        }
        httpController: HttpController {
            @display("p=40,150;i=block/cogwheel");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
}

network SimpleLan
{
    parameters:
        int numHosts;
    submodules:
        host[numHosts]: StandardHost {
            @display("p=75,175,r,60");
        }
        switch: EtherSwitch {
            @display("p=160,105");
        }
        server: StandardHost {
            @display("p=160,35");
        }
        configurator: Ipv4NetworkConfigurator {
            @display("p=40,30");
        }
        visualizer: IntegratedVisualizer {
            @display("p=40,90");
        }
    connections:
        for i=0..numHosts-1 {
            host[i].ethg++ <--> Eth100M <--> switch.ethg++;
        }
        switch.ethg++ <--> Eth100M <--> server.ethg++;
}

