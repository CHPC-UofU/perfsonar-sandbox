#!/usr/bin/env python

"""This CloudLab profile allocates four XenVM nodes, allocates routable IPv4s for each, and connects them directly together via a LAN.

Instructions:
Click on any node in the topology and choose the `shell` menu item. When your shell window appears, use `ping` to test the link."""

# Import the Portal object.
import geni.portal as portal
# Import the ProtoGENI library.
import geni.rspec.pg as pg
# Emulab specific extensions.
import geni.rspec.emulab as emulab

# Create a portal context, needed to define parameters
pc = portal.Context()

# Create a Request object to start building the RSpec.
request = pc.makeRequestRSpec()

# Variable number of nodes.
pc.defineParameter("nodeCount", "Number of Nodes", portal.ParameterType.INTEGER, 6)

# Pick your OS.
imageList = [
    ('urn:publicid:IDN+emulab.net+image+emulab-ops//CENTOS7-64-STD', 'CENTOS7-64-STD'),
    ('urn:publicid:IDN+emulab.net+image+emulab-ops//CENTOS8S-64-STD', 'CENTOS8S-64-STD'),
    ('urn:publicid:IDN+emulab.net+image+emulab-ops//ROCKY9-64-STD', 'ROCKY9-64-STD')]

pc.defineParameter('osImage', "Select OS image",
                   portal.ParameterType.IMAGE,
                   imageList[0], imageList)

# Retrieve the values the user specifies during instantiation.
params = pc.bindParameters()

# Check parameter validity.
if params.nodeCount < 3:
    pc.reportError(portal.ParameterError("You must choose at least 3 nodes.", ["nodeCount"]))

pc.verifyParameters()

# Create the best effort LAN between the VM nodes.
lan = request.LAN()
lan.best_effort = True

# Add VMs to the request that can be accessed from the public Internet.
for i in range(params.nodeCount):
    vmName = "%s-%d" % ('vm', i)
    node = request.XenVM(vmName)
    node.cores = 4
    node.ram = 8192
    node.routable_control_ip = True
    node.disk_image = params.osImage
    iface = node.addInterface("eth1")
    lan.addInterface(iface)

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
