# CIS-4.2.1 - \[Kubelet\] Ensure that the --anonymous-auth argument is set to false

## Control Statement

Disable anonymous requests to the Kubelet server.

## Control rationale_statement

When enabled, requests that are not rejected by other configured authentication methods are treated as anonymous requests. These requests are then served by the Kubelet server. You should rely on authentication to authorize access and disallow anonymous requests.

## Control impact_statement

Anonymous requests will be rejected.

## Control remediation_procedure

Follow the instructions in the documentation to create a Kubelet config CRD and set the `anonymous-auth` is set to `false`.

## Control audit_procedure

In OpenShift 4, the kublet config file is managed by the Machine Config Operator and `anonymous-auth` is set to `false` by default.

Run the following command on each node:

```

for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host grep -B4 -A1 anonymous: /etc/systemd/system/kubelet.conf
done
```

Verify that the `anonymous-auth` argument is set to `false`.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
