# CIS-1.1.3 - \[Master Node Configuration Files\] Ensure that the controller manager pod specification file permissions are set to 600 or more restrictive

## Control Statement

Ensure that the controller manager pod specification file has permissions of `600` or more restrictive.

## Control rationale_statement

The controller manager pod specification file controls various parameters that set the behavior of the Controller Manager on the master node. You should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.

## Control impact_statement

None

## Control remediation_procedure

execute command:

```
chmod 600 /etc/kubernetes/static-pod-resources/kube-controller-manager-pod.yaml
```

## Control audit_procedure

OpenShift 4 deploys two controller managers: the OpenShift Controller manager and the Kube Controller manager. 

The OpenShift Controller manager is managed as a deployment. The pod specification yaml for openshift-controller-manager is stored in etcd. 

The Kube Controller manager is managed as a static pod. The pod specification file for the openshift-kube-controller-manager is created on control plane nodes at /etc/kubernetes/manifests/kube-controller-manager-pod.yaml. It is mounted via hostpath to the kube-controller-manager pods via /etc/kubernetes/static-pod-resources/kube-controller-manager-pod.yaml with permissions 0644.

To verify pod specification file permissions for the kube-controller-manager, run the following command.

```
#echo "check openshift-kube-controller-manager pod specification file permissions"

for i in $( oc get pods -n openshift-kube-controller-manager -o name -l app=kube-controller-manager)
do
 oc exec -n openshift-kube-controller-manager $i -- \
 stat -c %a /etc/kubernetes/static-pod-resources/kube-controller-manager-pod.yaml
done
```

Verify that the permissions are 600 or more restrictive.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
