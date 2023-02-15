# CIS-4.1.1 - \[Worker Node Configuration Files\] Ensure that the kubelet service file permissions are set to 600 or more restrictive

## Control Statement

Ensure that the kubelet service file has permissions of 600 or more restrictive.

## Control rationale_statement

The kubelet service file controls various parameters that set the behavior of the kubelet service in the worker node. You should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.

## Control impact_statement

None

## Control remediation_procedure

execute command:

```
chmod 600 /etc/systemd/system/kubelet.service
```

## Control audit_procedure

Kubelet is run as a `systemd` unit and its configuration file is created with `644` permissions.

Run the following command:

```

for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host stat -c %a /etc/systemd/system/kubelet.service
done
```

Verify that the permissions are `600` or more restrictive.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
