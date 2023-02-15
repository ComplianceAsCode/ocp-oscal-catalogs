# CIS-1.2.16 - \[API Server\] Ensure that the admission control plugin SecurityContextConstraint is set

## Control Statement

Reject creating pods that do not match Pod Security Policies.

## Control rationale_statement

A Pod Security Policy is a cluster-level resource that controls the actions that a pod can perform and what it has the ability to access. The `PodSecurityPolicy` objects define a set of conditions that a pod must run with in order to be accepted into the system. Pod Security Policies are composed of settings and strategies that control the security features a pod has access to and hence this must be used to control pod access permissions.

Note: When the `PodSecurityPolicy` admission plugin is in use, there needs to be at least one `PodSecurityPolicy` in place for ANY pods to be admitted. See section 5.2 for recommendations on `PodSecurityPolicy` settings.

## Control impact_statement

Default Security Context Constraint objects are present on the cluster and granted by default based on roles. Custom SCCs can be created and granted as needed.

## Control remediation_procedure

None required. Security Context Constraints are enabled by default in OpenShift and cannot be disabled.

## Control audit_procedure

OpenShift provides the same protection via the SecurityContextConstraints admission plugin, which is enabled by default. The `PodSecurityPolicy` admission control plugin is disabled by default as it is still beta and not yet supported with OpenShift. Security Context Constraints (SCCs) and Pod Security Policy cannot be used on the same cluster.

Run the following command:

```
#Verify the set of admission-plugins for OCP 4.6 and higher
oc -n openshift-kube-apiserver get configmap config -o json | jq -r '.data."config.yaml"' | jq '.apiServerArguments."enable-admission-plugins"'

#Check that no overrides are configured
oc get kubeapiservers.operator.openshift.io cluster -o json | jq -r '.spec.unsupportedConfigOverrides'

#Verify that SecurityContextConstraints are deployed
oc get scc
oc describe scc restricted
```

In OCP 4.5 and earlier, the default set of admission plugins are compiled into the `apiserver` and are not visible in the configuration yaml. and does include.

For 4.6 and above, verify that the set of admission plugins includes `SecurityContextConstraint` and that the `--disable-admission-plugins` argument is set to a value that does not include `SecurityContextConstraint`. 

Verify that no unsupported Overrides are configured.

Verify that the list of SCCs includes `anyuid`, `hostaccess`, `hostmount-anyuid`, `hostnetwork`, `node-exporter`, `nonroot`, `privileged`, `restricted` 

Verify that the restricted SCC sets `Allowed Privileged` to `false`.

## Control CIS_Controls

TITLE:Leverage Vetted Modules or Services for Application Security Components CONTROL:v8 16.11 DESCRIPTION:Leverage vetted modules or services for application security components, such as identity management, encryption, and auditing and logging. Using platform features in critical security functions will reduce developers’ workload and minimize the likelihood of design or implementation errors. Modern operating systems provide effective mechanisms for identification, authentication, and authorization and make those mechanisms available to applications. Use only standardized, currently accepted, and extensively reviewed encryption algorithms. Operating systems also provide mechanisms to create and maintain secure audit logs.;TITLE:Apply Host-based Firewalls or Port Filtering CONTROL:v7 9.4 DESCRIPTION:Apply host-based firewalls or port filtering tools on end systems, with a default-deny rule that drops all traffic except those services and ports that are explicitly allowed.;
