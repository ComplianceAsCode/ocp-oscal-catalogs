# CIS-1.2.9 - \[API Server\] Verify that RBAC is enabled

## Control Statement

Turn on Role Based Access Control.

## Control rationale_statement

Role Based Access Control (RBAC) allows fine-grained control over the operations that different entities can perform on different objects in the cluster. It is recommended to use the RBAC authorization mode.

## Control impact_statement

When RBAC is enabled you will need to ensure that appropriate RBAC settings (including Roles, RoleBindings and ClusterRoleBindings) are configured to allow appropriate access.

## Control remediation_procedure

None. It is not possible to disable RBAC.

## Control audit_procedure

OpenShift is configured at bootstrap time to use RBAC to authorize requests. Role-based access control (RBAC) objects determine what actions a user is allowed to perform on what objects in an OpenShift cluster. Cluster administrators manage RBAC for the cluster. Project owners can manage RBAC for their individual OpenShift projects. The OpenShift API server `configmap` does not use the `authorization-mode` flag. 

To verify, run the following commands:

```
# For 4.5 To verify that the authorization-mode argument is not used 
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments' 
oc get configmap config -n openshift-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments'

#Check that no overrides are configured
oc get kubeapiservers.operator.openshift.io cluster -o json | jq -r '.spec.unsupportedConfigOverrides'

# To verify RBAC is used
oc get clusterrolebinding
oc get clusterrole
oc get rolebinding
oc get role

# For 4.6, verify that the authorization-mode argument includes RBAC
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments["authorization-mode"]' 
```

For OCP 4.5, verify that the `authorization-mode` argument is not present. Verify the expected roles and role bindings are returned. 

For OCP 4.6 and above, verify that the `authorization-mode` argument includes RBAC.

Verify the no overrides are configured.

## Control CIS_Controls

TITLE:Define and Maintain Role-Based Access Control CONTROL:v8 6.8 DESCRIPTION:Define and maintain role-based access control, through determining and documenting the access rights necessary for each role within the enterprise to successfully carry out its assigned duties. Perform access control reviews of enterprise assets to validate that all privileges are authorized, on a recurring schedule at a minimum annually, or more frequently.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
