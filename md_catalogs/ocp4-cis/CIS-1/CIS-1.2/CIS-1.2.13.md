# CIS-1.2.13 - \[API Server\] Ensure that the admission control plugin SecurityContextDeny is not set

## Control Statement

The `SecurityContextDeny` admission controller can be used to deny pods which make use of some `SecurityContext` fields which could allow for privilege escalation in the cluster. This should be used where `PodSecurityPolicy` is not in place within the cluster.

## Control rationale_statement

`SecurityContextDeny` can be used to provide a layer of security for clusters which do not have `PodSecurityPolicies` enabled.

## Control impact_statement

The `SecurityContextDeny` admission controller cannot be enabled as it conflicts with the `SecurityContextConstraint` admission controller.

## Control remediation_procedure

None required. The Security Context Constraint admission controller cannot be disabled in OpenShift 4.

## Control audit_procedure

In OpenShift, RBAC roles can restrict access to pod subresources 'exec' and 'attach', while Security Context Constraints (SCCs) restrict access to run privileged containers. By default, OpenShift runs pods on worker nodes as unprivileged (with the restricted SCC). Unlike upstream Kubernetes, OpenShift does not enable the `SecurityContextDeny` admission control plugin. OpenShift's Security Context Constraint (SCC) admission controller provides the same level of restriction as Pod Security Policy (PSP). PSPs are still beta in Kubernetes.

Run the following commands:

```
#Verify the set of admission-plugins for OCP 4.6 and higher
oc -n openshift-kube-apiserver get configmap config -o json | jq -r '.data."config.yaml"' | jq '.apiServerArguments."enable-admission-plugins"'

#Check that no overrides are configured
oc get kubeapiservers.operator.openshift.io cluster -o json | jq -r '.spec.unsupportedConfigOverrides'

#Verify that SecurityContextConstraints are deployed
oc get scc
oc describe scc restricted
```

Verify that the list of admission controllers does not include `SecurityContextDeny`. 

For 4.6 and above, verify that the set of admission plugins includes `SecurityContextConstraint` and that the `--disable-admission-plugins` argument is set to a value that does not include `SecurityContextConstraint`. In OCP 4.5 and earlier, the default set of admission plugins are compiled into the `apiserver` and are not visible in the configuration yaml. and does include.

Verify that no unsupported Overrides are configured.

Verify that the list of SCCs includes `anyuid`, `hostaccess`, `hostmount-anyuid`, `hostnetwork`, `node-exporter`, `nonroot`, `privileged`, `restricted` 

Verify that the restricted SCC sets `Allowed Privileged` to `false`.

## Control CIS_Controls

TITLE:Leverage Vetted Modules or Services for Application Security Components CONTROL:v8 16.11 DESCRIPTION:Leverage vetted modules or services for application security components, such as identity management, encryption, and auditing and logging. Using platform features in critical security functions will reduce developers’ workload and minimize the likelihood of design or implementation errors. Modern operating systems provide effective mechanisms for identification, authentication, and authorization and make those mechanisms available to applications. Use only standardized, currently accepted, and extensively reviewed encryption algorithms. Operating systems also provide mechanisms to create and maintain secure audit logs.;TITLE:Ensure Only Approved Ports, Protocols and Services Are Running CONTROL:v7 9.2 DESCRIPTION:Ensure that only network ports, protocols, and services listening on a system with validated business needs, are running on each system.;
