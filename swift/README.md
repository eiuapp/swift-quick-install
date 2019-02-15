OpenStack Docs: Object Storage Install Guide

Object Storage Install Guide
----------------------------

updated: 2019-01-15 02:30

Object Storage Install Guide[¶](#object-storage-install-guide "Permalink to this headline")
===========================================================================================

*   [Object Storage service overview](get_started.html)
*   [Configure networking](environment-networking.html)
    *   [First node](environment-networking.html#first-node)
    *   [Second node](environment-networking.html#second-node)
*   [Install and configure the controller node](controller-install.html)
    *   [Install and configure the controller node for Ubuntu](controller-install-ubuntu.html)
*   [Install and configure the storage nodes](storage-install.html)
    *   [Install and configure the storage nodes for Ubuntu and Debian](storage-install-ubuntu-debian.html)
*   [Create and distribute initial rings](initial-rings.html)
    *   [Create account ring](initial-rings.html#create-account-ring)
    *   [Create container ring](initial-rings.html#create-container-ring)
    *   [Create object ring](initial-rings.html#create-object-ring)
    *   [Distribute ring configuration files](initial-rings.html#distribute-ring-configuration-files)
*   [Finalize installation](finalize-installation.html)
    *   [Finalize installation for Ubuntu and Debian](finalize-installation-ubuntu-debian.html)
*   [Verify operation](verify.html)
*   [Next steps](next-steps.html)

The Object Storage services (swift) work together to provide object storage and retrieval through a REST API.

This chapter assumes a working setup of OpenStack following the [OpenStack Installation Tutorial](http://docs.openstack.org/#install-guides).

Your environment must at least include the Identity service (keystone) prior to deploying Object Storage.

updated: 2019-01-15 02:30