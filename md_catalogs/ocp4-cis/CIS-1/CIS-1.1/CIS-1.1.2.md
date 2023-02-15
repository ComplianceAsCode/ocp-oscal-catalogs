# CIS-1.1.2 - \[Master Node Configuration Files\] Ensure that the API server pod specification file ownership is set to root:root

## Control Statement

Ensure that the API server pod specification file ownership is set to `root:root`.

## Control rationale_statement

The API server pod specification file controls various parameters that set the behavior of the API server. You should set its file ownership to maintain the integrity of the file. The file should be owned by `root:root`.

## Control impact_statement

None

## Control remediation_procedure

No remediation required; file permissions are managed by the operator.

## Control audit_procedure

OpenShift 4 deploys two API servers: the OpenShift API server and the Kube API server. 

The OpenShift API server is managed as a deployment. The pod specification yaml for openshift-apiserver is stored in etcd. 

The Kube API Server is managed as a static pod. The pod specification file for the kube-apiserver is created on the control plane nodes at /etc/kubernetes/manifests/kube-apiserver-pod.yaml. The kube-apiserver is mounted via hostpath to the kube-apiserver pods via /etc/kubernetes/static-pod-resources/kube-apiserver-pod.yaml with ownership `root:root`.

To verify pod specification file ownership for the kube-apiserver, run the following command.

```
#echo “check kube-apiserver pod specification file ownership”

for i in $( oc get pods -n openshift-kube-apiserver -l app=openshift-kube-apiserver -o name )
do
 oc exec -n openshift-kube-apiserver $i -- \
 stat -c %U:%G /etc/kubernetes/static-pod-resources/kube-apiserver-pod.yaml
done
```
Verify that the ownership is set to `root:root`.

## Control CIS_Controls

TITLE:Restrict Administrator Privileges to Dedicated Administrator Accounts CONTROL:v8 5.4 DESCRIPTION:Restrict administrator privileges to dedicated administrator accounts on enterprise assets. Conduct general computing activities, such as internet browsing, email, and productivity suite use, from the user’s primary, non-privileged account.;TITLE:Ensure the Use of Dedicated Administrative Accounts CONTROL:v7 4.3 DESCRIPTION:Ensure that all users with administrative account access use a dedicated or secondary account for elevated activities. This account should only be used for administrative activities and not internet browsing, email, or similar activities.;
