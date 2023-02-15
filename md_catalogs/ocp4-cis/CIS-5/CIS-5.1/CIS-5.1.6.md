# CIS-5.1.6 - \[RBAC and Service Accounts\] Ensure that Service Account Tokens are only mounted where necessary

## Control Statement

Service accounts tokens should not be mounted in pods except where the workload running in the pod explicitly needs to communicate with the API server

## Control rationale_statement

Mounting service account tokens inside pods can provide an avenue for privilege escalation attacks where an attacker is able to compromise a single pod in the cluster.

Avoiding mounting these tokens removes this attack avenue.

## Control impact_statement

Pods mounted without service account tokens will not be able to communicate with the API server, except where the resource is available to unauthenticated principals.

## Control remediation_procedure

Modify the definition of pods and service accounts which do not need to mount service account tokens to disable it.

## Control audit_procedure

Review pod and service account objects in the cluster and ensure that the option below is set, unless the resource explicitly requires this access.

```
automountServiceAccountToken: false
```

## Control CIS_Controls

TITLE:Only Allow Access to Authorized Cloud Storage or Email Providers CONTROL:v7 13.4 DESCRIPTION:Only allow access to authorized cloud storage or email providers.;
