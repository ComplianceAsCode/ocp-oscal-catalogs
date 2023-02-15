# CIS-5.3.2 - \[Network Policies and CNI\] Ensure that all Namespaces have Network Policies defined

## Control Statement

Use network policies to isolate traffic in your cluster network.

## Control rationale_statement

Running different applications on the same Kubernetes cluster creates a risk of one compromised application attacking a neighboring application. Network segmentation is important to ensure that containers can communicate only with those they are supposed to. A network policy is a specification of how selections of pods are allowed to communicate with each other and other network endpoints.

Once there is any Network Policy in a namespace selecting a particular pod, that pod will reject any connections that are not allowed by any Network Policy. Other pods in the namespace that are not selected by any Network Policy will continue to accept all traffic

## Control impact_statement

Once there is any Network Policy in a namespace selecting a particular pod, that pod will reject any connections that are not allowed by any Network Policy. Other pods in the namespace that are not selected by any Network Policy will continue to accept all traffic"

## Control remediation_procedure

Follow the documentation and create `NetworkPolicy` objects as you need them.

## Control audit_procedure

The OpenShift 4 CNI plugin uses network policies and by default all Pods in a project are accessible from other Pods and network endpoints. To isolate one or more Pods in a project, you create NetworkPolicy objects in that project to indicate the allowed incoming connections. Project administrators can create and delete NetworkPolicy objects within their own project. For more information see: 

Run the following command and review the `NetworkPolicy` objects created in the cluster.

```
oc -n all get networkpolicy
```

Ensure that each namespace defined in the cluster has at least one Network Policy.

## Control CIS_Controls

TITLE:Implement and Manage a Firewall on Servers CONTROL:v8 4.4 DESCRIPTION:Implement and manage a firewall on servers, where supported. Example implementations include a virtual firewall, operating system firewall, or a third-party firewall agent.;TITLE:Enable Firewall Filtering Between VLANs CONTROL:v7 14.2 DESCRIPTION:Enable firewall filtering between VLANs to ensure that only authorized systems are able to communicate with other systems necessary to fulfill their specific responsibilities.;
