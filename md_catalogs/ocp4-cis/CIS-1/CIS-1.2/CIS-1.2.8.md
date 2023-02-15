# CIS-1.2.8 - \[API Server\] Verify that the Node authorizer is enabled

## Control Statement

Restrict kubelet nodes to reading only objects associated with them.

## Control rationale_statement

The Node authorization mode only allows kubelets to read `Secret`, `ConfigMap`, `PersistentVolume`, and `PersistentVolumeClaim` objects associated with their nodes.

## Control impact_statement

None

## Control remediation_procedure

No remediation is required.

## Control audit_procedure

In OpenShift, the Node authorizer is enabled by default and is not configurable. In OpenShift 4.5 and earlier the OpenShift API server `configmap` does not use the `authorization-mode` flag. 

```
# For OCP 4.5 and earlier verify that authorization-mode is not used
oc get configmap config -n openshift-kube-apiserver -ojson | jq -r '.data["config.yaml"]' | jq '.apiServerArguments' 
oc get kubeapiservers.operator.openshift.io cluster -o json | jq '.spec.observedConfig.apiServerArguments'

# For OCP 4.5 and earlier verify that authorization-mode is not used
for node in $(oc get nodes -o jsonpath='{.items[*].metadata.name}')
do
 oc debug node/${node} -- chroot /host cat /etc/kubernetes/kubelet.conf | grep authorization-mode
 oc debug node/${node} -- chroot /host ps -aux | grep kubelet | grep authorization-mode
done

#Check that no overrides are configured
oc get kubeapiservers.operator.openshift.io cluster -o json | jq -r '.spec.unsupportedConfigOverrides'
```

For OCP 4.5, verify that the `authorization-mode` argument is not present. 

For OCP 4.6 and above, verify that the `authorization-mode` argument includes `Node`.

Verify the no overrides are configured.

## Control CIS_Controls

TITLE:Configure Data Access Control Lists CONTROL:v8 3.3 DESCRIPTION:Configure data access control lists based on a user’s need to know. Apply data access control lists, also known as access permissions, to local and remote file systems, databases, and applications.;TITLE:Ensure Only Approved Ports, Protocols and Services Are Running CONTROL:v7 9.2 DESCRIPTION:Ensure that only network ports, protocols, and services listening on a system with validated business needs, are running on each system.;
