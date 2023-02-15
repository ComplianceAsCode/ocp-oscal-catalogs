# CIS-1.2.19 - \[API Server\] Ensure that the --insecure-port argument is set to 0

## Control Statement

Do not bind to insecure port.

## Control rationale_statement

Setting up the `apiserver` to serve on an insecure port would allow unauthenticated and unencrypted access to your master node. This would allow attackers who could access this port, to easily take control of the cluster.

## Control impact_statement

All components that use the API must connect via the secured port, authenticate themselves, and be authorized to use the API.

This includes:
- kube-controller-manager
- kube-proxy
- kube-scheduler
- kubelets

## Control remediation_procedure

None required. The configuration is managed by the API server operator.

## Control audit_procedure

The `openshift-kube-apiserver` is served over HTTPS with authentication and authorization; the secure API endpoint is bound to `0.0.0.0:6443` by default. By default the `insecure-port` argument is set to `0`. Note that the `openshift-apiserver` is not running in the host network namespace. The port is not exposed on the node, but only through the pod network.

Run the following command:

```
# Should return 6443
oc -n openshift-kube-apiserver get endpoints -o jsonpath='{.items[*].subsets[*].ports[*].port}'

# For OCP 4.6 and above
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments["insecure-port"]'
```

Verify that the `openshift-kube-apiserver` container-port is set to `6443`. 

For OCP 4.6 and above, verify that `--insecure-port` argument in the API server operator configs is set to `0`. 

Note that the parameter `kube-apiserver-insecure-readyz` has the argument `insecure-port` set to `6080`. This value should not be changed.

## Control CIS_Controls

TITLE:Leverage Vetted Modules or Services for Application Security Components CONTROL:v8 16.11 DESCRIPTION:Leverage vetted modules or services for application security components, such as identity management, encryption, and auditing and logging. Using platform features in critical security functions will reduce developers’ workload and minimize the likelihood of design or implementation errors. Modern operating systems provide effective mechanisms for identification, authentication, and authorization and make those mechanisms available to applications. Use only standardized, currently accepted, and extensively reviewed encryption algorithms. Operating systems also provide mechanisms to create and maintain secure audit logs.;TITLE:Apply Host-based Firewalls or Port Filtering CONTROL:v7 9.4 DESCRIPTION:Apply host-based firewalls or port filtering tools on end systems, with a default-deny rule that drops all traffic except those services and ports that are explicitly allowed.;
