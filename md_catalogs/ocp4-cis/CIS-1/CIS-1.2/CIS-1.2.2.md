# CIS-1.2.2 - \[API Server\] Ensure that the --basic-auth-file argument is not set

## Control Statement

Do not use basic authentication.

## Control rationale_statement

Basic authentication uses plaintext credentials for authentication. Currently, the basic authentication credentials last indefinitely, and the password cannot be changed without restarting the API server. The basic authentication is currently supported for convenience. Hence, basic authentication should not be used.

## Control impact_statement

OpenShift uses tokens and certificates for authentication.

## Control remediation_procedure

None required. `--basic-auth-file` cannot be configured on OpenShift.

## Control audit_procedure

OpenShift provides it's own fully integrated authentication and authorization mechanism. The `apiserver` is protected by either requiring an OAuth token issued by the platform's integrated OAuth server or signed certificates. The `basic-auth-file` method is not enabled in OpenShift. 

Run the following command:

```
oc -n openshift-kube-apiserver get cm config -o yaml | grep --color "basic-auth"
oc -n openshift-apiserver get cm config -o yaml | grep --color "basic-auth"
oc get clusteroperator authentication
```

Verify that the `--basic-auth-file` argument does not exist. 

Verify that the `authentication-operator` is running: Available is True.

## Control CIS_Controls

TITLE:Securely Manage Enterprise Assets and Software CONTROL:v8 4.6 DESCRIPTION:Securely manage enterprise assets and software. Example implementations include managing configuration through version-controlled-infrastructure-as-code and accessing administrative interfaces over secure network protocols, such as Secure Shell (SSH) and Hypertext Transfer Protocol Secure (HTTPS). Do not use insecure management protocols, such as Telnet (Teletype Network) and HTTP, unless operationally essential.;TITLE:Encrypt or Hash all Authentication Credentials CONTROL:v7 16.4 DESCRIPTION:Encrypt or hash with a salt all authentication credentials when stored.;
