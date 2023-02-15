# CIS-1.1.19 - \[Master Node Configuration Files\] Ensure that the OpenShift PKI directory and file ownership is set to root:root

## Control Statement

Ensure that the OpenShift PKI directory and file ownership is set to `root:root`.

## Control rationale_statement

OpenShift makes use of a number of certificates as part of its operation. You should verify the ownership of the directory containing the PKI information and all files in that directory to maintain their integrity. The directory and files should be owned by `root:root`.

## Control impact_statement

None

## Control remediation_procedure

No remediation required; file permissions are managed by the operator.

## Control audit_procedure

Keys for control plane components deployed as static pods, `kube-apiserver`, `kube-controller-manager`, and `openshift-kube-scheduler` are stored in the directory `/etc/kubernetes/static-pod-certs/secrets`. The directory and file ownership are set to `root:root`.

Run the following command.

```
# Should return root:root for all files and directories

for i in $(oc -n openshift-kube-apiserver get pod -l app=openshift-kube-apiserver -o jsonpath='{.items[*].metadata.name}')
do
 echo $i static-pod-certs
 oc exec -n openshift-kube-apiserver $i -c kube-apiserver -- \
 find /etc/kubernetes/static-pod-certs -type d -wholename '*/secrets*' -exec stat -c %U:%G {} \;
 oc exec -n openshift-kube-apiserver $i -c kube-apiserver -- \
 find /etc/kubernetes/static-pod-certs -type f -wholename '*/secrets*' -exec stat -c %U:%G {} \;
 echo $i static-pod-resources
 oc exec -n openshift-kube-apiserver $i -c kube-apiserver -- \
 find /etc/kubernetes/static-pod-resources -type d -wholename '*/secrets*' -exec stat -c %U:%G {} \;
 oc exec -n openshift-kube-apiserver $i -c kube-apiserver -- \
 find /etc/kubernetes/static-pod-resources -type f -wholename '*/secrets*' -exec stat -c %U:%G {} \;
done
```

Verify that the ownership of all files and directories in this hierarchy is set to `root:root`.

## Control CIS_Controls

TITLE:Restrict Administrator Privileges to Dedicated Administrator Accounts CONTROL:v8 5.4 DESCRIPTION:Restrict administrator privileges to dedicated administrator accounts on enterprise assets. Conduct general computing activities, such as internet browsing, email, and productivity suite use, from the user’s primary, non-privileged account.;TITLE:Ensure the Use of Dedicated Administrative Accounts CONTROL:v7 4.3 DESCRIPTION:Ensure that all users with administrative account access use a dedicated or secondary account for elevated activities. This account should only be used for administrative activities and not internet browsing, email, or similar activities.;
