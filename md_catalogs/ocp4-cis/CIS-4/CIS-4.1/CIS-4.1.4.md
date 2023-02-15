# CIS-4.1.4 - \[Worker Node Configuration Files\] If proxy kubeconfig file exists ensure ownership is set to root:root

## Control Statement

If `kube-proxy` is running, ensure that the file ownership of its kubeconfig file is set to `root:root`.

## Control rationale_statement

The kubeconfig file for `kube-proxy` controls various parameters for the `kube-proxy` service in the worker node. You should set its file ownership to maintain the integrity of the file. The file should be owned by `root:root`.

## Control impact_statement

None

## Control remediation_procedure

None required. The configuration is managed by OpenShift operators.

## Control audit_procedure

In OpenShift 4, the `kube-proxy` runs within the `sdn` pods, which copies the `kubeconfig` from a configmap to the container at `/tmp/kubeconfig`, with root:root ownership. 

Run the following command:

```
for i in $(oc get pods -n openshift-sdn -l app=sdn -oname)
do
 oc exec -n openshift-sdn $i -- \
 stat -Lc %U:%G /config/kube-proxy-config.yaml
done
```

Verify that the `kube-proxy-config.yaml` file has ownership root:root.

## Control CIS_Controls

TITLE:Restrict Administrator Privileges to Dedicated Administrator Accounts CONTROL:v8 5.4 DESCRIPTION:Restrict administrator privileges to dedicated administrator accounts on enterprise assets. Conduct general computing activities, such as internet browsing, email, and productivity suite use, from the user’s primary, non-privileged account.;
