# CIS-4.1.7 - \[Worker Node Configuration Files\] Ensure that the certificate authorities file permissions are set to 600 or more restrictive

## Control Statement

Ensure that the certificate authorities file has permissions of `600` or more restrictive.

## Control rationale_statement

The certificate authorities file controls the authorities used to validate API requests. You should restrict its file permissions to maintain the integrity of the file. The file should be writable by only the administrators on the system.

## Control impact_statement

None

## Control remediation_procedure

execute command:

```
chmod 600 /etc/kubernetes/cert/ca.pem
```

## Control audit_procedure

The Client CA location for the `kubelet` is defined in `/etc/kubernetes/kubelet.conf`. The 
`/etc/kubernetes/cert/kubelet-ca.crt` file has permissions `600`.

Run the following command:

```

for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host stat -c %a /etc/kubernetes/cert/ca.pem
done
```

Verify that the permissions are `600`.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
