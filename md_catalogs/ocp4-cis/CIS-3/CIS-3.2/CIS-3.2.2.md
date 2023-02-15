# CIS-3.2.2 - \[Logging\] Ensure that the audit policy covers key security concerns

## Control Statement

Ensure that the audit policy created for the cluster covers key security concerns.

## Control rationale_statement

Security audit logs should cover access and modification of key resources in the cluster, to enable them to form an effective part of a security environment.

## Control impact_statement

Increasing audit logging will consume resources on the nodes or other log destinations.

## Control remediation_procedure

In OpenShift 4.6 and higher, if appropriate for your needs, modify the audit policy.

## Control audit_procedure

Review the audit policy provided for the cluster and ensure that it covers at least the following areas:

- Access to Secrets managed by the cluster. Care should be taken to only log Metadata for requests to Secrets, ConfigMaps, and TokenReviews, in order to avoid the risk of logging sensitive data.
- Modification of pod and deployment objects.
- Use of `pods/exec`, `pods/portforward`, `pods/proxy and services/proxy`.

For most requests, minimally logging at the Metadata level is recommended (the most basic level of logging).

Audit policy is supported as of OpenShift 4.6, but not in earlier versions. You can configure the audit feature to set log level, retention policy, and the type of events to log. You can set the log level settings for an overall component or the API server to one of the following. The setting can be different for each setting.

```

#To verify openshift apiserver audit config
oc get configmap config -n openshift-kube-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq '.auditConfig.policyConfiguration.rules[]'

#To verify kube apiserver audit config
oc get configmap config -n openshift-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq '.auditConfig.policyConfiguration.rules[]'
```

## Control CIS_Controls

TITLE:Enforce Detail Logging for Access or Changes to Sensitive Data CONTROL:v7 14.9 DESCRIPTION:Enforce detailed audit logging for access to sensitive data or changes to sensitive data (utilizing tools such as File Integrity Monitoring or Security Information and Event Monitoring).;TITLE:Enforce Detailed Audit Logging For Sensitive Information CONTROL:v6 14.6 DESCRIPTION:Enforce detailed audit logging for access to nonpublic data and special authentication for sensitive data.;
