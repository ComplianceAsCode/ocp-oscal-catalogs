# CIS-5.7.1 - \[General Policies\] Create administrative boundaries between resources using namespaces

## Control Statement

Use namespaces to isolate your Kubernetes objects.

## Control rationale_statement

Limiting the scope of user permissions can reduce the impact of mistakes or malicious activities. A Kubernetes namespace allows you to partition created resources into logically named groups. Resources created in one namespace can be hidden from other namespaces. By default, each resource created by a user in Kubernetes cluster runs in a default namespace, called `default`. You can create additional namespaces and attach resources and users to them. You can use Kubernetes Authorization plugins to create policies that segregate access to namespace resources between different users.

## Control impact_statement

You need to switch between namespaces for administration.

## Control remediation_procedure

Follow the documentation and create namespaces for objects in your deployment as you need them.

## Control audit_procedure

OpenShift Projects wrap Kubernetes namespaces and are used by default in OpenShift 4. 

Run the following command and review the namespaces created in the cluster.

```
oc get namespaces
```

Ensure that these namespaces are the ones you need and are adequately administered as per your requirements.

## Control CIS_Controls

TITLE:Implement and Manage a Firewall on Servers CONTROL:v8 4.4 DESCRIPTION:Implement and manage a firewall on servers, where supported. Example implementations include a virtual firewall, operating system firewall, or a third-party firewall agent.;TITLE:Implement Application Firewalls CONTROL:v7 9.5 DESCRIPTION:Place application firewalls in front of any critical servers to verify and validate the traffic going to the server. Any unauthorized traffic should be blocked and logged.;
