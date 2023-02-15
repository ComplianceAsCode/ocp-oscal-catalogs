# CIS-1.3.1 - \[Controller Manager\] Ensure that garbage collection is configured as appropriate

## Control Statement

Activate garbage collector on pod termination, as appropriate.

## Control rationale_statement

Garbage collection is important to ensure sufficient resource availability and avoiding degraded performance and availability. In the worst case, the system might crash or just be unusable for a long period of time. The current setting for garbage collection is 12,500 terminated pods which might be too high for your system to sustain. Based on your system resources and tests, choose an appropriate threshold value to activate garbage collection.

## Control impact_statement

None

## Control remediation_procedure

To configure, follow the directions in [Configuring garbage collection for containers and images](
https://docs.openshift.com/container-platform/4.5/nodes/nodes/nodes-nodes-garbage-collection.html#nodes-nodes-garbage-collection-configuring_nodes-nodes-configuring)

## Control audit_procedure

Two types of garbage collection are performed on an OpenShift Container Platform node: 

- Container garbage collection: Removes terminated containers.
- Image garbage collection: Removes images not referenced by any running pods.

Container garbage collection can be performed using eviction thresholds. Image garbage collection relies on disk usage as reported by cAdvisor on the node to decide which images to remove from the node. Default values are found here https://github.com/openshift/kubernetes-kubelet/blob/origin-4.5-kubernetes-1.18.3/config/v1beta1/types.go#L554-L604

The OpenShift administrator can configure how OpenShift Container Platform performs garbage collection by creating a `kubeletConfig` object for each Machine Config Pool using any combination of the following:

- soft eviction for containers
- hard eviction for containers
- eviction for images

To configure, follow the directions in 

https://docs.openshift.com/container-platform/4.5/nodes/nodes/nodes-nodes-garbage-collection.html#nodes-nodes-garbage-collection-configuring_nodes-nodes-configuring

To verify settings, run the following command for each updated `configpool`

```
oc get machineconfigpool

# For each machineconfigpool
oc describe machineconfigpool <name>

#For example
oc describe machineconfigpool master
oc describe machineconfigpool worker
```

Verify the values for the following are set as appropriate.

`eviction-soft`
`evictionSoftGracePeriod`
`evictionHard`
`evictionPressureTransitionPeriod`

## Control CIS_Controls

TITLE:Enable Anti-Exploitation Features CONTROL:v8 10.5 DESCRIPTION:Enable anti-exploitation features on enterprise assets and software, where possible, such as Microsoft® Data Execution Prevention (DEP), Windows® Defender Exploit Guard (WDEG), or Apple® System Integrity Protection (SIP) and Gatekeeper™.;TITLE:Establish Secure Configurations CONTROL:v7 5.1 DESCRIPTION:Maintain documented, standard security configuration standards for all authorized operating systems and software.;
