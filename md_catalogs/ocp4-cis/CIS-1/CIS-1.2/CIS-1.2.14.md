# CIS-1.2.14 - \[API Server\] Ensure that the admission control plugin ServiceAccount is set

## Control Statement

Automate service accounts management.

## Control rationale_statement

When you create a pod, if you do not specify a service account, it is automatically assigned the default service account in the same namespace. You should create your own service account and let the API server manage its security tokens.

## Control impact_statement

None.

## Control remediation_procedure

None required. OpenShift is configured to use service accounts by default.

## Control audit_procedure

The ServiceAccount admission control plugin is enabled by default. Every service account has an associated user name that can be granted roles, just like a regular user. The user name for each service account is derived from its project and the name of the service account. Service accounts are required in each project to run builds, deployments, and other pods. The default service accounts that are automatically created for each project are isolated by the project namespace.

Run the following commands:

```
#Verify the list of admission controllers for 4.6 and higher
oc -n openshift-kube-apiserver get configmap config -o json | jq -r '.data."config.yaml"' | jq '.apiServerArguments."enable-admission-plugins"'

#Check that no overrides are configured
oc get kubeapiservers.operator.openshift.io cluster -o json | jq -r '.spec.unsupportedConfigOverrides'

#Verify that Service Accounts are present
oc get sa -A
```

For 4.6 and above, verify that the set of admission plugins does include `ServiceAccount` and that the `--disable-admission-plugins` argument is set to a value that does not include `ServiceAccount`. 

In OCP 4.5 and earlier, the default set of admission plugins are compiled into the `apiserver` and are not visible in the configuration yaml. and does include.

Verify that no unsupported Overrides are configured.

Verify that Service Accounts are present for every namespace.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Protect Information through Access Control Lists CONTROL:v7 14.6 DESCRIPTION:Protect all information stored on systems with file system, network share, claims, application, or database specific access control lists. These controls will enforce the principle that only authorized individuals should have access to the information based on their need to access the information as a part of their responsibilities.;
