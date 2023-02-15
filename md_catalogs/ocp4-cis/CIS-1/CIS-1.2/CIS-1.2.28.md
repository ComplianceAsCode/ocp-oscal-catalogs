# CIS-1.2.28 - \[API Server\] Ensure that the --service-account-key-file argument is set as appropriate

## Control Statement

Explicitly set a service account public key file for service accounts on the apiserver.

## Control rationale_statement

By default, if no `--service-account-key-file` is specified to the `apiserver`, it uses the private key from the TLS serving certificate to verify service account tokens. To ensure that the keys for service account tokens could be rotated as needed, a separate public/private key pair should be used for signing service account tokens. Hence, the public key should be specified to the `apiserver` with `--service-account-key-file`.

## Control impact_statement

The corresponding private key must be provided to the controller manager. You would need to securely maintain the key file and rotate the keys based on your organization's key rotation policy.

## Control remediation_procedure

The OpenShift API server does not use the `service-account-key-file` argument. The `ServiceAccount` token `authenticator` is configured with `serviceAccountConfig.publicKeyFiles`. OpenShift does not reuse the apiserver TLS key. This is not configurable.

## Control audit_procedure

OpenShift API server does not use the service-account-key-file argument. OpenShift does not reuse the apiserver TLS key. The ServiceAccount token authenticator is configured with `serviceAccountConfig.publicKeyFiles`. OpenShift automatically manages and rotates the keys. 

Run the following command:

```
oc get configmap config -n openshift-kube-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq -r .serviceAccountPublicKeyFiles[]
```

Verify that the following is returned.

`/etc/kubernetes/static-pod-resources/configmaps/sa-token-signing-certs`
`/etc/kubernetes/static-pod-resources/configmaps/bound-sa-token-signing-certs`

## Control CIS_Controls

TITLE:Use Unique Passwords CONTROL:v8 5.2 DESCRIPTION:Use unique passwords for all enterprise assets. Best practice implementation includes, at a minimum, an 8-character password for accounts using MFA and a 14-character password for accounts not using MFA. ;TITLE:Use Unique Passwords CONTROL:v7 4.4 DESCRIPTION:Where multi-factor authentication is not supported (such as local administrator, root, or service accounts), accounts will use passwords that are unique to that system.;
