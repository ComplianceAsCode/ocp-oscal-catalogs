# CIS-1.1.20 - \[Master Node Configuration Files\] Ensure that the OpenShift PKI certificate file permissions are set to 600 or more restrictive

## Control Statement

Ensure that OpenShift PKI certificate files have permissions of `644` or more restrictive.

## Control rationale_statement

OpenShift makes use of a number of certificate files as part of the operation of its components. The permissions on these files should be set to 644 or more restrictive to protect their integrity.

## Control impact_statement

None

## Control remediation_procedure

No remediation required; file permissions are managed by the operator.

## Control audit_procedure

Certificates for control plane components like `kube-apiserver`, `kube-controller-manager`, and `kube-scheduler` are stored in the directory `/etc/kubernetes/static-pod-certs/secrets`. Certificate files all have permissions `600`.

Run the following command.

```
# Should 600 or more restrictive

for i in $(oc -n openshift-kube-apiserver get pod -l app=openshift-kube-apiserver -o jsonpath='{.items[*].metadata.name}')
do
 echo $i static-pod-certs
 oc exec -n openshift-kube-apiserver $i -c kube-apiserver -- \
 find /etc/kubernetes/static-pod-certs -type f -wholename '*/secrets/*.crt' -exec stat -c %a {} \;
done
```

Verify that the permissions are `600`.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
