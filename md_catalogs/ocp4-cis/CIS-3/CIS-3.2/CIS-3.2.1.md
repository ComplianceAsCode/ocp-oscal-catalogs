# CIS-3.2.1 - \[Logging\] Ensure that a minimal audit policy is created

## Control Statement

Kubernetes can audit the details of requests made to the API server. The `--audit-policy-file` flag must be set for this logging to be enabled.

## Control rationale_statement

Logging is an important detective control for all systems, to detect potential unauthorised access.

## Control impact_statement

Audit logs will be created on the master nodes, which will consume disk space. Care should be taken to avoid generating too large volumes of log information as this could impact the available of the cluster nodes.

## Control remediation_procedure

No remediation required.

## Control audit_procedure

In OpenShift, auditing of the API Server is on by default. Audit provides a security-relevant chronological set of records documenting the sequence of activities that have affected the system by individual users, administrators, or other components of the system. Audit works at the API server level, logging all requests coming to the server. Each audit log contains two entries:

The request line containing:

A Unique ID allowing to match the response line (see #2)
- The source IP of the request
- The HTTP method being invoked
- The original user invoking the operation
- The impersonated user for the operation (self meaning himself)
- The impersonated group for the operation (lookup meaning user’s group)
- The namespace of the request or <none>
- The URI as requested

The response line containing:
- The unique ID from #1
- The response code

You can view logs for the OpenShift Container Platform API server or the Kubernetes API server for each master node. Follow the steps in documentation. [Viewing the audit log](https://docs.openshift.com/container-platform/4.5/nodes/nodes/nodes-nodes-audit-log.html#nodes-nodes-audit-log-basic-viewing_nodes-nodes-audit-log)

```

#To view kube apiserver log files
oc adm node-logs --role=master --path=kube-apiserver/

#To view openshift apiserver log files
oc adm node-logs --role=master --path=openshift-apiserver/

#To verify kube apiserver audit config
oc get configmap config -n openshift-kube-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq '.auditConfig[]'

#To verify openshift apiserver audit config
oc get configmap config -n openshift-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq '.auditConfig[]'
```

Verify that log files are returned. 

Verify the audit log configuration.

## Control CIS_Controls

TITLE:Activate audit logging CONTROL:v7 6.2 DESCRIPTION:Ensure that local logging has been enabled on all systems and networking devices.;
