#!/usr/bin/env python

"""This profile allocates three bare metal nodes and connects them directly together via a layer1 link.

Instructions:
Click on any node in the topology and choose the `shell` menu item. When your shell window appears, use `ping` to test the link."""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# Import the Emulab specific extensions.
import geni.rspec.emulab as emulab

# Define OS image
OS_IMAGE = 'urn:publicid:IDN+emulab.net+image+emulab-ops:CENTOS7-64-STD'

# Create a portal context.
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Add a raw Archive PC to the request and give it an interface.
archivePC = request.RawPC("archive")
archivePC.disk_image = OS_IMAGE
ifaceArchivePC = archivePC.addInterface()
ifaceArchivePC.addAddress(pg.IPv4Address("192.168.1.1", "255.255.255.0"))

# Add a raw Testpoint PC to the request and give it an interface.
testpointPC = request.RawPC("testpoint")
testpointPC.disk_image = OS_IMAGE
ifaceTestpointPC = testpointPC.addInterface()
ifaceTestpointPC.addAddress(pg.IPv4Address("192.168.1.2", "255.255.255.0"))

# Add a raw Toolkit PC to the request and give it an interface.
toolkitPC = request.RawPC("toolkit")
toolkitPC.disk_image = OS_IMAGE
ifaceToolkitPC = toolkitPC.addInterface()
ifaceToolkitPC.addAddress(pg.IPv4Address("192.168.1.3", "255.255.255.0"))

# Add L1 link between all nodes.
link1 = request.L1Link("link1")
link1.addInterface(ifaceArchivePC)
link1.addInterface(ifaceTestpointPC)
link1.addInterface(ifaceToolkitPC)

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
