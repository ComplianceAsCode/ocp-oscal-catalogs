# CIS-4.2.8 - \[Kubelet\] Ensure that the --hostname-override argument is not set

## Control Statement

Do not override node hostnames.

## Control rationale_statement

Overriding hostnames could potentially break TLS setup between the kubelet and the apiserver. Additionally, with overridden hostnames, it becomes increasingly difficult to associate logs with a particular node and process them for security analytics. Hence, you should setup your kubelet nodes with resolvable FQDNs and avoid overriding the hostnames with IPs.

## Control impact_statement

Some cloud providers may require this flag to ensure that hostname matches names issued by the cloud provider. In these environments, this recommendation should not apply.

## Control remediation_procedure

None required.

## Control audit_procedure

In OpenShift 4, the `--hostname-override` argument is not used. 

Run the following command on each machine pool. For example:

```
oc get machineconfig 01-worker-kubelet -o yaml | grep hostname-override
oc get machineconfig 01-master-kubelet -o yaml | grep hostname-override
```

Verify that `--hostname-override` argument does not exist.

## Control CIS_Controls

TITLE:Use DNS Filtering Services CONTROL:v8 9.2 DESCRIPTION:Use DNS filtering services on all enterprise assets to block access to known malicious domains.;TITLE:Use of DNS Filtering Services CONTROL:v7 7.7 DESCRIPTION:Use DNS filtering services to help block access to known malicious domains.;
