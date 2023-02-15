# CIS-1.1.17 - \[Master Node Configuration Files\] Ensure that the controller-manager.conf file permissions are set to 600 or more restrictive

## Control Statement

Ensure that the `controller-manager.conf` file has permissions of `644` or more restrictive.

## Control rationale_statement

The `controller-manager.conf` file is the `kubeconfig` file for the Controller Manager. You should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.

## Control impact_statement

None

## Control remediation_procedure

execute command:

```
chmod 600 /etc/kubernetes/static-pod-resources/configmaps/controller-manager-kubeconfig/kubeconfig/controller-manager.conf
```

## Control audit_procedure

The `kubeconfig` file for `kube-controller-manager` is stored in the ConfigMap `controller-manager-kubeconfig` in the namespace `openshift-kube-controller-manager`. The file `kubeconfig` (`controller-manager.conf`) is referenced in the pod via `hostpath` and is stored in `/etc/kubernetes/static-pod-resources/configmaps/controller-manager-kubeconfig/kubeconfig` with permissions `644`.

Run the following command.

```
for i in $(oc get pods -n openshift-kube-controller-manager -l app=kube-controller-manager -oname)
 do
 oc exec -n openshift-kube-controller-manager $i -- \
 stat -c %a /etc/kubernetes/static-pod-resources/configmaps/controller-manager-kubeconfig/kubeconfig/controller-manager.conf
 done
```

Verify that the permissions are `600` or more restrictive.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
