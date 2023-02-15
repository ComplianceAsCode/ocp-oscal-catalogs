# CIS-1.2.1 - \[API Server\] Ensure that anonymous requests are authorized

## Control Statement

When anonymous requests to the API server are allowed, they must be authorized.

## Control rationale_statement

When enabled, requests that are not rejected by other configured authentication methods are treated as anonymous requests. These requests are then served by the API server. You should rely on authentication to authorize anonymous requests.

If you are using RBAC authorization, it is generally considered reasonable to allow anonymous access to the API Server for health checks and discovery purposes, and hence this recommendation is not scored. However, you should consider whether anonymous discovery is an acceptable risk for your purposes.

## Control impact_statement

Anonymous requests are assigned to the `system:unauthenticated` group which allows the system to determine which actions are allowed.

## Control remediation_procedure

None required. The default configuration should not be modified.

## Control audit_procedure

OpenShift allows anonymous requests (then authorizes them). OpenShift allows anonymous requests to the API server to support information discovery and `webhook` integrations. OpenShift provides it's own fully integrated authentication and authorization mechanism. If no access token or certificate is presented, the authentication layer assigns the `system:anonymous` virtual user and the `system:unauthenticated` virtual group to the request. This allows the authorization layer to determine which requests, if any, an anonymous user is allowed to make.

```
# To verify that userGroups include system:unauthenticated
oc get configmap config -n openshift-kube-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq '.auditConfig.policyConfiguration.rules[]'

# To verify that userGroups include system:unauthenticated
oc get configmap config -n openshift-apiserver -ojson | \
 jq -r '.data["config.yaml"]' | \
 jq '.auditConfig.policyConfiguration.rules[]'

# To verify RBAC is enabled
oc get clusterrolebinding
oc get clusterrole
oc get rolebinding
oc get role
```

Verify that the userGroups include `system:unauthenticated`.

Verify that role bindings and roles are returned.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
