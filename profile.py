#!/usr/bin/env python

"""This profile allocates four XenVM nodes, allocates routable IPv4s for each, and connects them directly together via a LAN.

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

# perfSONAR bundles.
bundleList = [('archive', 1), ('testpoint', 2), ('toolkit', 1)]

# Pick your OS.
imageList = [
    ('urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD', 'CENTOS7-64-STD')]

# Create, bind, and verify some user-configurable parameters.
pc.defineParameter('osImage', "Select OS image",
                   portal.ParameterType.IMAGE,
                   imageList[0], imageList)
params = pc.bindParameters()
pc.verifyParameters()

# Create the best effort LAN between the VM nodes.
lan = request.LAN()
lan.best_effort = True

# Add VMs to the request that can be accessed from the public Internet.
for bundle in bundleList:
    bundleName = bundle[0]
    bundleCount = bundle[1]

    for i in range(bundleCount):
        vmName = "%s-%d" % (bundleName, i)
        node = request.XenVM(vmName)
        node.routable_control_ip = True
        node.disk_image = params.osImage
        iface = node.addInterface("eth1")
        lan.addInterface(iface)

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
