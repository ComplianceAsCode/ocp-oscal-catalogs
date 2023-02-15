# CIS-1.2.34 - \[API Server\] Ensure that encryption providers are appropriately configured

## Control Statement

Where `etcd` encryption is used, appropriate providers should be configured.

## Control rationale_statement

Where `etcd` encryption is used, it is important to ensure that the appropriate set of encryption providers is used. Currently, the `aescbc`, `kms` and `secretbox` are likely to be appropriate options.

## Control impact_statement

When you enable `etcd` encryption, the following OpenShift API server and Kubernetes API server resources are encrypted:

- Secrets
- ConfigMaps
- Routes
- OAuth access tokens
- OAuth authorize tokens

When you enable `etcd` encryption, encryption keys are created. These keys are rotated on a weekly basis. You must have these keys in order to restore from an `etcd` backup.

## Control remediation_procedure

Follow the OpenShift documentation for [Encrypting etcd data | Authentication | OpenShift Container Platform 4.5](https://docs.openshift.com/container-platform/4.5/security/encrypting-etcd.html)

## Control audit_procedure

OpenShift supports encryption of data at rest of `etcd` datastore, but it is up to the customer to configure. The `asecbc` cipher is used. No other ciphers are supported. Keys are stored on the filesystem of the master and automatically rotated.

Run the following command to review the Encrypted status condition for the OpenShift API server to verify that its resources were successfully encrypted:

```
# encrypt the etcd datastore 
oc get openshiftapiserver -o=jsonpath='{range .items[0].status.conditions[?(@.type=="Encrypted")]}{.reason}{"\n"}{.message}{"\n"}'
```

The output shows EncryptionCompleted upon successful encryption. 

- `EncryptionCompleted`
- `All resources encrypted: routes.route.openshift.io, oauthaccesstokens.oauth.openshift.io, oauthauthorizetokens.oauth.openshift.io`

If the output shows `EncryptionInProgress`, this means that encryption is still in progress. Wait a few minutes and try again.

## Control CIS_Controls

TITLE:Encrypt Sensitive Data at Rest CONTROL:v8 3.11 DESCRIPTION:Encrypt sensitive data at rest on servers, applications, and databases containing sensitive data. Storage-layer encryption, also known as server-side encryption, meets the minimum requirement of this Safeguard. Additional encryption methods may include application-layer encryption, also known as client-side encryption, where access to the data storage device(s) does not permit access to the plain-text data. ;TITLE:Encrypt Sensitive Information at Rest CONTROL:v7 14.8 DESCRIPTION:Encrypt all sensitive information at rest using a tool that requires a secondary authentication mechanism not integrated into the operating system, in order to access the information.;
