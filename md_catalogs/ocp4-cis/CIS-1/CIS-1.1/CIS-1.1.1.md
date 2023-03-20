# CIS-1.1.1 - \[Master Node Configuration Files\] Ensure that the API server pod specification file permissions are set to 600 or more restrictive

## Control Statement

Ensure that the API server pod specification file has permissions of `600` or more restrictive.

## Control rationale_statement

The API server pod specification file controls various parameters that set the behavior of the API server. You should restrict its file permissions to maintain the integrity of the file. The file should be writable only by the administrators on the system.

## Control impact_statement

Test

## Control remediation_procedure

execute command:

```
chmod 600 /etc/kubernetes/static-pod-resources/kube-apiserver-pod.yaml
```

## Control audit_procedure

OpenShift 4 deploys two API servers: the OpenShift API server and the Kube API server. The OpenShift API server delegates requests for Kubernetes objects to the Kube API server.

The OpenShift API server is managed as a deployment. The pod specification yaml for openshift-apiserver is stored in etcd. 

The Kube API Server is managed as a static pod. The pod specification file for the kube-apiserver is created on the control plane nodes at /etc/kubernetes/manifests/kube-apiserver-pod.yaml. The kube-apiserver is mounted via hostpath to the kube-apiserver pods via /etc/kubernetes/static-pod-resources/kube-apiserver-pod.yaml with permissions 0644.

To verify pod specification file permissions for the kube-apiserver, run the following command.

```
#echo “check kube-apiserver pod specification file permissions”

for i in $( oc get pods -n openshift-kube-apiserver -l app=openshift-kube-apiserver -o name )
do
 oc exec -n openshift-kube-apiserver $i -- \
 stat -c %a /etc/kubernetes/static-pod-resources/kube-apiserver-pod.yaml
done
```

Verify that the permissions are 600 or more restrictive.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
