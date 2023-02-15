# CIS-1.2.22 - \[API Server\] Ensure that the --audit-log-path argument is set

## Control Statement

Enable auditing on the Kubernetes API Server and set the desired audit log path.

## Control rationale_statement

Auditing the Kubernetes API Server provides a security-relevant chronological set of records documenting the sequence of activities that have affected the system by individual users, administrators or other components of the system. Even though currently, Kubernetes provides only basic audit capabilities, it should be enabled. You can enable it by setting an appropriate audit log path.

## Control impact_statement

None

## Control remediation_procedure

None required. This is managed by the cluster `apiserver` operator.

## Control audit_procedure

OpenShift audit works at the API server level, logging all requests coming to the server. API server audit is on by default.

Run the following command:

```
# Should return “/var/log/kube-apiserver/audit.log”
oc get configmap config -n openshift-kube-apiserver -o jsonpath="{['.data.config\.yaml']}" | jq '.auditConfig.auditFilePath'

POD=$(oc get pods -n openshift-kube-apiserver -l app=openshift-kube-apiserver -o jsonpath='{.items[0].metadata.name}')
oc rsh -n openshift-kube-apiserver -c kube-apiserver $POD ls /var/log/kube-apiserver/audit.log

# Should return 0
echo $?

# Should return "/var/log/openshift-apiserver/audit.log"
oc get configmap config -n openshift-apiserver -o jsonpath="{['.data.config\.yaml']}" | jq '.auditConfig.auditFilePath'

POD=$(oc get pods -n openshift-apiserver -l apiserver=true -o jsonpath='{.items[0].metadata.name}')
oc rsh -n openshift-apiserver $POD ls /var/log/openshift-apiserver/audit.log

# Should return 0
echo $?
```

Verify that the `auditFilePath` is set to `/var/log/kube-apiserver/audit.log` for `openshift-kube-apiserver` and to `/var/log/openshift-apiserver/audit.log` for `openshift-apiserver`.

## Control CIS_Controls

TITLE:Collect Detailed Audit Logs CONTROL:v8 8.5 DESCRIPTION:Configure detailed audit logging for enterprise assets containing sensitive data. Include event source, date, username, timestamp, source addresses, destination addresses, and other useful elements that could assist in a forensic investigation.;TITLE:Activate audit logging CONTROL:v7 6.2 DESCRIPTION:Ensure that local logging has been enabled on all systems and networking devices.;TITLE:Enable Detailed Logging CONTROL:v7 6.3 DESCRIPTION:Enable system logging to include detailed information such as an event source, date, user, timestamp, source addresses, destination addresses, and other useful elements.;
