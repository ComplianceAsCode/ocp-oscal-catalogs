# CIS-1.2.27 - \[API Server\] Ensure that the --service-account-lookup argument is set to true

## Control Statement

Validate service account before validating token.

## Control rationale_statement

If `--service-account-lookup` is not enabled, the `apiserver` only verifies that the authentication token is valid, and does not validate that the service account token mentioned in the request is actually present in `etcd`. This allows using a service account token even after the corresponding service account is deleted. This is an example of time of check to time of use security issue.

## Control impact_statement

None

## Control remediation_procedure

TBD

## Control audit_procedure

OpenShift denies access for any OAuth Access token that does not exist in its `etcd` data store. OpenShift does not use the `service-account-lookup` flag even when it is set. 

Run the following command:

```
# For OCP 4.5 
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments' | grep service-account-lookup

# For OCP 4.6 and above
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq -r ‘.service-account-lookup’
```

For OpenShift 4.5, verify that the `service-account-lookup` argument does not exist. 

For OpenShift 4.6 and above, verify that if the `--service-account-lookup` argument exists it is set to `true`.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Enforce Access Control to Data through Automated Tools CONTROL:v7 14.7 DESCRIPTION:Use an automated tool, such as host-based Data Loss Prevention, to enforce access controls to data even when data is copied off a system.;
