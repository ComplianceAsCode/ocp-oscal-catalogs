# CIS-4.2.9 - \[Kubelet\] Ensure that the kubeAPIQPS [--event-qps] argument is set to 0 or a level which ensures appropriate event capture

## Control Statement

Security relevant information should be captured. The `--event-qps` flag on the Kubelet can be used to limit the rate at which events are gathered. Setting this too low could result in relevant events not being logged, however the unlimited setting of `0` could result in a denial of service on the kubelet.

## Control rationale_statement

It is important to capture all events and not restrict event creation. Events are an important source of security information and analytics that ensure that your environment is consistently monitored using the event data.

## Control impact_statement

Setting this parameter to `0` could result in a denial of service condition due to excessive events being created. The cluster's event processing and storage systems should be scaled to handle expected event loads.

## Control remediation_procedure

Follow the documentation to edit kubelet parameters

https://docs.openshift.com/container-platform/4.5/scalability_and_performance/recommended-host-practices.html#create-a-kubeletconfig-crd-to-edit-kubelet-parameters

```
KubeAPIQPS: <QPS>
```

## Control audit_procedure

OpenShift uses the `kubeAPIQPS` argument and sets it to a default value of `50`. When this value is set to > 0, event creations per second are limited to the value set. If this value is set to `0`, event creations per second are unlimited.

Run the following command on each machine pool. For example:

```

for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}'); do oc debug node/${node} -- chroot /host more /etc/kubernetes/kubelet.conf; done

oc get machineconfig 01-worker-kubelet -o yaml | grep --color kubeAPIQPS%3A%2050

oc get machineconfig 01-master-kubelet -o yaml | grep --color kubeAPIQPS%3A%2050
```

Review the value set for the `kubeAPIQPS` argument and determine whether this has been set to an appropriate level for the cluster. If this value is set to `0`, event creations per second are unlimited.

## Control CIS_Controls

TITLE:Collect Detailed Audit Logs CONTROL:v8 8.5 DESCRIPTION:Configure detailed audit logging for enterprise assets containing sensitive data. Include event source, date, username, timestamp, source addresses, destination addresses, and other useful elements that could assist in a forensic investigation.;TITLE:Enable Command-line Audit Logging CONTROL:v7 8.8 DESCRIPTION:Enable command-line audit logging for command shells, such as Microsoft Powershell and Bash.;
