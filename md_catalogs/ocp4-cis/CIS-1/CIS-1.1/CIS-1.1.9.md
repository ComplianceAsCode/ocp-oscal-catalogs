# CIS-1.1.9 - \[Master Node Configuration Files\] Ensure that the Container Network Interface file permissions are set to 600 or more restrictive

## Control Statement

Ensure that the Container Network Interface files have permissions of `600` or more restrictive.

## Control rationale_statement

Container Network Interface provides various networking options for overlay networking. You should consult their documentation and restrict their respective file permissions to maintain the integrity of those files. Those files should be writable by only the administrators on the system.

## Control impact_statement

None

## Control remediation_procedure

No remediation required; file permissions are managed by the operator.

## Control audit_procedure

The Cluster Network Operator (CNO) deploys and manages the cluster network components on an OpenShift Container Platform cluster. This includes the Container Network Interface (CNI) default network provider plug-in selected for the cluster during installation. OpenShift Container Platform uses the Multus CNI plug-in to allow chaining of CNI plug-ins. The default Pod network must be configured during cluster installation. By default, the CNO deploys the OpenShift SDN as the default Pod network. 

Ensure that the Container Network Interface file permissions, multus, openshift-sdn and Open vSwitch (OVS) file permissions are set to 644 or more restrictive. The SDN components are deployed as DaemonSets across the master/worker nodes with controllers limited to control plane nodes. OpenShift deploys OVS as a network overlay by default. Various configurations (ConfigMaps and other files managed by the operator via hostpath but stored on the container hosts) are stored in the following locations:

CNI/Multus (pod muluts):

`/host/etc/cni/net.d = CNI_CONF_DIR`
`/host/var/run/multus/cni/net.d = multus config dir`

SDN (pod ovs; daemonset; app=ovs):

`/var/lib/cni/networks/openshift-sdn `
`/var/run/openshift-sdn`

OVS (container openvswitch):

`/var/run/openvswitch`
`/etc/openvswitch`
`/run/openvswitch`

Run the following commands. 

```

# For CNI multus
for i in $(oc get pods -n openshift-multus -l app=multus -oname); do oc exec -n openshift-multus $i -- /bin/bash -c "stat -c \"%a %n\" /host/etc/cni/net.d/*.conf"; done

for i in $(oc get pods -n openshift-multus -l app=multus -oname); do oc exec -n openshift-multus $i -- /bin/bash -c "stat -c \"%a %n\" /host/var/run/multus/cni/net.d/*.conf"; done

# For SDN pods
for i in $(oc get pods -n openshift-sdn -l app=sdn -oname); do oc exec -n openshift-sdn $i -- find /var/lib/cni/networks/openshift-sdn -type f -exec stat -c %a {} \;; done

for i in $(oc get pods -n openshift-sdn -l app=sdn -oname); do oc exec -n openshift-sdn $i -- find /var/run/openshift-sdn -type f -exec stat -c %a {} \;; done

# For OVS pods
for i in $(oc get pods -n openshift-sdn -l app=ovs -oname); do oc exec -n openshift-sdn $i -- find /var/run/openvswitch -type f -exec stat -c %a {} \;; done 

for i in $(oc get pods -n openshift-sdn -l app=ovs -oname); do oc exec -n openshift-sdn $i -- find /etc/openvswitch -type f -exec stat -c %a {} \;; done 

for i in $(oc get pods -n openshift-sdn -l app=ovs -oname); do oc exec -n openshift-sdn $i -- find /run/openvswitch -type f -exec stat -c %a {} \;; done 
```

Verify that the config files for the CNI multus pods have permissions of 600 or more restrictive. 

`/host/etc/cni/net.d/00-multus.conf = 600`
`/host/var/run/multus/cni/net.d/80-openshift-network.conf = 600`

Verify that the SDN pods permissions are 600 or more restrictive.

`/var/lib/cni/networks/openshift-sdn/* = 600`
`/var/run/openshift-sdn/cniserver/config.json = 600`

Verify that the OVS permissions are 600 or more restrictive.

`/var/run/openvswitch/ovs-vswitchd.pid = 600`
`/etc/openvswitch/conf.db = 600`
`/etc/openvswitch/system-id.conf = 600`
`/etc/openvswitch/.conf.db.~lock~ = 600`
`/run/openvswitch/ovs-vswitchd.pid = 600`
`/run/openvswitch/ovsdb-server.pid = 644`

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
