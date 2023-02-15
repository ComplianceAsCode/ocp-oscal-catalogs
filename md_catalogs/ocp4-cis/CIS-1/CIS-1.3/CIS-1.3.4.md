# CIS-1.3.4 - \[Controller Manager\] Ensure that the --service-account-private-key-file argument is set as appropriate

## Control Statement

Explicitly set a service account private key file for service accounts on the controller manager.

## Control rationale_statement

To ensure that keys for service account tokens can be rotated as needed, a separate public/private key pair should be used for signing service account tokens. The private key should be specified to the controller manager with `--service-account-private-key-file` as appropriate.

## Control impact_statement

You would need to securely maintain the key file and rotate the keys based on your organization's key rotation policy.

## Control remediation_procedure

None required. OpenShift manages the service account credentials for the scheduler automatically.

## Control audit_procedure

OpenShift starts the Kubernetes Controller Manager with service-account-private-key-file set to `/etc/kubernetes/static-pod-resources/secrets/service-account-private-key/service-account.key`. 

The bootstrap configuration and overrides are available here: 

[kube-controller-manager-pod](https://github.com/openshift/cluster-kube-controller-manager-operator/blob/release-4.5/bindata/bootkube/bootstrap-manifests/kube-controller-manager-pod.yaml)

[bootstrap-config-overrides](https://github.com/openshift/cluster-kube-controller-manager-operator/blob/release-4.5/bindata/bootkube/config/bootstrap-config-overrides.yaml)

Run the following command:

```
oc get configmaps config -n openshift-kube-controller-manager -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq -r '.extendedArguments["service-account-private-key-file"][]'
```

Verify that the following is returned

`/etc/kubernetes/static-pod-resources/secrets/service-account-private-key/service-account.key`

## Control CIS_Controls

TITLE:Use Unique Passwords CONTROL:v8 5.2 DESCRIPTION:Use unique passwords for all enterprise assets. Best practice implementation includes, at a minimum, an 8-character password for accounts using MFA and a 14-character password for accounts not using MFA. ;TITLE:Use Unique Passwords CONTROL:v7 4.4 DESCRIPTION:Where multi-factor authentication is not supported (such as local administrator, root, or service accounts), accounts will use passwords that are unique to that system.;
