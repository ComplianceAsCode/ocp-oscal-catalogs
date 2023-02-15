# CIS-1.2.17 - \[API Server\] Ensure that the admission control plugin NodeRestriction is set

## Control Statement

Limit the `Node` and `Pod` objects that a kubelet could modify.

## Control rationale_statement

Using the `NodeRestriction` plug-in ensures that the kubelet is restricted to the `Node` and `Pod` objects that it could modify as defined. Such kubelets will only be allowed to modify their own `Node` API object, and only modify `Pod` API objects that are bound to their node.

## Control impact_statement

None

## Control remediation_procedure

The `NodeRestriction` plugin cannot be disabled.

## Control audit_procedure

In OpenShift, the `NodeRestriction` admission plugin is enabled by default.

Run the following command:

````
# For 4.5, review the control plane manifest
https://github.com/openshift/origin/blob/release-4.5/vendor/k8s.io/kubernetes/cmd/kubeadm/app/phases/controlplane/manifests.go#L132

#Verify the set of admission-plugins for OCP 4.6 and higher
oc -n openshift-kube-apiserver get configmap config -o json | jq -r '.data."config.yaml"' | jq '.apiServerArguments."enable-admission-plugins"'

#Check that no overrides are configured
oc get kubeapiservers.operator.openshift.io cluster -o json | jq -r '.spec.unsupportedConfigOverrides'
````

In OCP 4.5 and earlier, the default set of admission plugins are compiled into the `apiserver` and are not visible in the configuration yaml. 

For 4.6 and above, verify that the set of admission plugins includes `NodeRestriction` and that the `--disable-admission-plugins` argument is set to a value that does not include `NodeRestriction`. 

Verify that no unsupported Overrides are configured.

## Control CIS_Controls

TITLE:Leverage Vetted Modules or Services for Application Security Components CONTROL:v8 16.11 DESCRIPTION:Leverage vetted modules or services for application security components, such as identity management, encryption, and auditing and logging. Using platform features in critical security functions will reduce developers’ workload and minimize the likelihood of design or implementation errors. Modern operating systems provide effective mechanisms for identification, authentication, and authorization and make those mechanisms available to applications. Use only standardized, currently accepted, and extensively reviewed encryption algorithms. Operating systems also provide mechanisms to create and maintain secure audit logs.;TITLE:Apply Host-based Firewalls or Port Filtering CONTROL:v7 9.4 DESCRIPTION:Apply host-based firewalls or port filtering tools on end systems, with a default-deny rule that drops all traffic except those services and ports that are explicitly allowed.;
