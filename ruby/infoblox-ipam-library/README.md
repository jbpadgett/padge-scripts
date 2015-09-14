IPAM  README
=================
Maintainer:  JBPadgett
Created: 6/2014
Status: Incomplete

Overview
==========
This is a ruby library that uses the Infoblox IPAM REST API also known as WAPI.  The library makes use of the infoblox gem which was a community gem not created by Infoblox.
The infobox gem only used the WAPI REST API via ruby and does not offer the same functionality as the infoblox ibcli or perl modules.  This is meant to be a pure ruby approach without all the perl dependencies of ibcli.
This library was designed to fit nicely into a Chef cookbook if desired.

Configuration
===============
The primary modifications if needed will be the ipam user account and password and the hostname of the infoblox admin appliance.

Usage
===============

TBD



