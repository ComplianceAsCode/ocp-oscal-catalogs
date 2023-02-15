# CIS-4.2.7 - \[Kubelet\] Ensure that the --make-iptables-util-chains argument is set to true

## Control Statement

Allow Kubelet to manage iptables.

## Control rationale_statement

Kubelets can automatically manage the required changes to iptables based on how you choose your networking options for the pods. It is recommended to let kubelets manage the changes to iptables. This ensures that the iptables configuration remains in sync with pods networking configuration. Manually configuring iptables with dynamic pod network configuration changes might hamper the communication between pods/containers and to the outside world. You might have iptables rules too restrictive or too open.

## Control impact_statement

Kubelet would manage the iptables on the system and keep it in sync. If you are using any other iptables management solution, then there might be some conflicts.

## Control remediation_procedure

None required. The `--make-iptables-util-chains` argument is set to true by default.

## Control audit_procedure

OpenShift sets the `make-iptables-util-changes` argument to true by default. 

Run the following command:

```

/bin/bash
flag=make-iptables-util-chains
opt=makeIPTablesUtilChains

# look at each machineconfigpool

while read -r pool nodeconfig; do
 # true by default
 value='true'
 # first look for the flag
 oc get machineconfig $nodeconfig -o json | jq -r '.spec.config.systemd[][] | select(.name=="kubelet.service") | .contents' | sed -n "/^ExecStart=/,/^\$/ { /^\\s*--$flag=false/ q 100 }"
 # if the above command exited with 100, the flag was false
 [ $? == 100 ] && value='false'
 # now look in the yaml KubeletConfig
 yamlconfig=$(oc get machineconfig $nodeconfig -o json | jq -r '.spec.config.storage.files[] | select(.path=="/etc/kubernetes/kubelet.conf") | .contents.source ' | sed 's/^data:,//' | while read; do echo -e ${REPLY//%/\\x}; done)
 echo "$yamlconfig" | sed -n "/^$opt:\\s*false\\s*$/ q 100"
 [ $? == 100 ] && value='false'
 echo "Pool $pool has $flag ($opt) set to $value"
done < <(oc get machineconfigpools -o json | jq -r '.items[] | select(.status.machineCount>0) | .metadata.name + " " + .spec.configuration.name')
```

Verify the `--make-iptables-util-chains` argument is set to true for each `machinepool`. 

For example:
`Pool master has make-iptables-util-chains (makeIPTablesUtilChains) set to true`
`Pool worker has make-iptables-util-chains (makeIPTablesUtilChains) set to true`

## Control CIS_Controls

TITLE:Implement and Manage a Firewall on Servers CONTROL:v8 4.4 DESCRIPTION:Implement and manage a firewall on servers, where supported. Example implementations include a virtual firewall, operating system firewall, or a third-party firewall agent.;TITLE:Enforce Access Control to Data through Automated Tools CONTROL:v7 14.7 DESCRIPTION:Use an automated tool, such as host-based Data Loss Prevention, to enforce access controls to data even when data is copied off a system.;
