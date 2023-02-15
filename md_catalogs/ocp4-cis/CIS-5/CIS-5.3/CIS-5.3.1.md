# CIS-5.3.1 - \[Network Policies and CNI\] Ensure that the CNI in use supports Network Policies

## Control Statement

There are a variety of CNI plugins available for Kubernetes. If the CNI in use does not support Network Policies it may not be possible to effectively restrict traffic in the cluster.

## Control rationale_statement

Kubernetes network policies are enforced by the CNI plugin in use. As such it is important to ensure that the CNI plugin supports both Ingress and Egress network policies.

## Control impact_statement

None

## Control remediation_procedure

None required.

## Control audit_procedure

Review the documentation of CNI plugin in use by the cluster, and confirm that it supports Ingress and Egress network policies.

OpenShift Container Platform uses a software-defined networking (SDN) approach to provide a unified cluster network that enables communication between Pods across the OpenShift Container Platform cluster. This Pod network is established and maintained by the OpenShift SDN, which configures an overlay network using Open vSwitch (OVS). The OpenShift SDN uses Network Policies. The OpenShift SDN CNI plug-in provides all Kubernetes v1 NetworkPolicy features except for egress policy types and IPBlock. However, OpenShift provides means to implement fine grained filtering of egress traffic. OpenShift provides several options for controlling the traffic leaving the cluster. These options are :

- Egress firewall
- Egress routers
- Egress static IP

## Control CIS_Controls

TITLE:Implement and Manage a Firewall on Servers CONTROL:v8 4.4 DESCRIPTION:Implement and manage a firewall on servers, where supported. Example implementations include a virtual firewall, operating system firewall, or a third-party firewall agent.;TITLE:Implement Application Firewalls CONTROL:v7 9.5 DESCRIPTION:Place application firewalls in front of any critical servers to verify and validate the traffic going to the server. Any unauthorized traffic should be blocked and logged.;
