#!/usr/bin/env python

"""This profile allocates three bare metal nodes and connects them directly together via a layer1 link.

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

# Pick your OS.
imageList = [
    ('urn:publicid:IDN+emulab.net+image+emulab-ops//UBUNTU22-64-STD', 'CENTOS7-64-STD')]

# Create, bind, and verify some user-configurable parameters.
pc.defineParameter('osImage', "Select OS image",
                   portal.ParameterType.IMAGE,
                   imageList[0], imageList)
params = pc.bindParameters()
pc.verifyParameters()

# Add an Archive VM to the request that can be accessed from the public Internet.
archive = request.XenVM("archive")
archive.disk_image = params.osImage
archive.routable_control_ip = True

# Add a Testpoint VM to the request that can be accessed from the public Internet.
testpoint1 = request.XenVM("testpoint1")
testpoint1.disk_image = params.osImage
testpoint1.routable_control_ip = True

# Add a Toolkit VM to the request that can be accessed from the public Internet.
toolkit = request.XenVM("toolkit")
toolkit.disk_image = params.osImage
toolkit.routable_control_ip = True

# Create a best effort LAN between them.
lan = request.LAN(members=[archive, testpoint1, toolkit])
lan.best_effort = True

# Print the RSpec to the enclosing page.
pc.printRequestRSpec(request)
